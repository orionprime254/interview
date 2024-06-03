import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/food_model.dart';


class ApiService {



  static const String _baseURL = 'http://api.spoonacular.com/recipes';
  static const String API_KEY = 'f060c12c3e124dc4a475ffe94a6463f1';


  Future<List<dynamic>> geRandomRecipes(int number)async{
    final response = await http.get(Uri.parse('$_baseURL/random?number=$number&apiKey=$API_KEY'));
    if (response.statusCode==200){
      final data = json.decode(response.body);
      return data['recipes'];
    }else{
      throw Exception('Failed to load food');
    }
  }
}
