import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:hive/hive.dart';
import '../services/api_services.dart';
import 'food_model.dart';
import 'package:path_provider/path_provider.dart';

part 'food_store.g.dart';

class FoodStore = _FoodStore with _$FoodStore;

abstract class _FoodStore with Store {
  final foodBox = Hive.box<Food>('foodsBox');
  final cartBox = Hive.box<Food>('cartBox');
  final apiService = ApiService();

  @observable
  ObservableList<Food> foods = ObservableList<Food>();

  @observable
  ObservableList<Food> cart = ObservableList<Food>();

  _FoodStore() {
    _initializeCart();
  }

  @action
  Future<void> fetchFoods() async {
    if (foodBox.isNotEmpty) {
      foods = ObservableList.of(foodBox.values.toList());
    } else {
      final fetchedFoods = await apiService.geRandomRecipes(20);
      for (var json in fetchedFoods) {
        try {
          Food food = Food.fromJson(json);
          food.localImagePath = await _downloadAndSaveImage(food.thumbnailUrl);
          foods.add(food);
          foodBox.add(food);
        } catch (e) {
          print('error parsing food item: $e');
        }
      }
      final foodList = fetchedFoods.map((json) => Food.fromJson(json)).toList();
      await foodBox.addAll(foodList);
      foods.addAll(foodList);
    }
  }

  Future<String?> _downloadAndSaveImage(String thumbnailUrl) async {
    if (thumbnailUrl.isEmpty) return null;
    try {
      final response = await http.get(Uri.parse(thumbnailUrl));
      if (response.statusCode == 200) {
        final documentDirectory = await getApplicationDocumentsDirectory();
        final file = File('${documentDirectory.path}/${Uri.parse(thumbnailUrl).pathSegments.last}');
        file.writeAsBytesSync(response.bodyBytes);
        return file.path;
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
    return null;
  }

  @action
  Future<void> addToCart(Food food) async {
    final Food foodClone = food.clone();
    cartBox.add(foodClone);
    cart.add(foodClone);
  }

  @action
  void removeFromCart(Food food) {
    final index = cart.indexOf(food);
    cartBox.deleteAt(index);
    cart.removeAt(index);
  }

  Future<void> _initializeCart() async {
    List<Food> storedCartItems = cartBox.values.toList();
    cart.addAll(storedCartItems);
  }
}
