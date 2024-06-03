// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FoodStore on _FoodStore, Store {
  late final _$foodsAtom = Atom(name: '_FoodStore.foods', context: context);

  @override
  ObservableList<Food> get foods {
    _$foodsAtom.reportRead();
    return super.foods;
  }

  @override
  set foods(ObservableList<Food> value) {
    _$foodsAtom.reportWrite(value, super.foods, () {
      super.foods = value;
    });
  }

  late final _$cartAtom = Atom(name: '_FoodStore.cart', context: context);

  @override
  ObservableList<Food> get cart {
    _$cartAtom.reportRead();
    return super.cart;
  }

  @override
  set cart(ObservableList<Food> value) {
    _$cartAtom.reportWrite(value, super.cart, () {
      super.cart = value;
    });
  }

  late final _$fetchFoodsAsyncAction =
      AsyncAction('_FoodStore.fetchFoods', context: context);

  @override
  Future<void> fetchFoods() {
    return _$fetchFoodsAsyncAction.run(() => super.fetchFoods());
  }

  late final _$addToCartAsyncAction =
      AsyncAction('_FoodStore.addToCart', context: context);

  @override
  Future<void> addToCart(Food food) {
    return _$addToCartAsyncAction.run(() => super.addToCart(food));
  }

  late final _$_FoodStoreActionController =
      ActionController(name: '_FoodStore', context: context);

  @override
  void removeFromCart(Food food) {
    final _$actionInfo = _$_FoodStoreActionController.startAction(
        name: '_FoodStore.removeFromCart');
    try {
      return super.removeFromCart(food);
    } finally {
      _$_FoodStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
foods: ${foods},
cart: ${cart}
    ''';
  }
}
