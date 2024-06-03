import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:interview/food_card.dart';
import 'package:interview/model/food_store.dart';
import 'package:interview/services/api_services.dart';
import 'package:provider/provider.dart';

import 'cart.dart';
import 'model/food_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FoodStore>(context,listen: false).fetchFoods();
  }
  @override
  Widget build(BuildContext context) {
    final foodStore = Provider.of<FoodStore>(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.restaurant),
              SizedBox(
                width: 10,
              ),
              Text('Food App')
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            )
          ],
        ),
        body: Observer(builder: (_) {
          if (foodStore.foods.isEmpty) {
            foodStore.fetchFoods();
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return ListView.builder(
              itemCount: foodStore.foods.length,
              itemBuilder: (context, index) {
                final food = foodStore.foods[index];
                return GestureDetector(onTap: (){},
                  child: FoodCard(
                    food: food,
                  ),
                );
              });
        }));
  }
}
