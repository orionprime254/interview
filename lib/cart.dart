import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:interview/food_card.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'checkout.dart';
import 'model/food_model.dart';
import 'model/food_store.dart';
import 'dart:convert';
class CartPage extends StatelessWidget {
  Future<void> _checkout(BuildContext context) async {
    final foodStore = Provider.of<FoodStore>(context, listen: false);

    // Dummy endpoint for the POST request
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'cart': foodStore.cart.map((food) => food.toJson()).toList()}),
    );

    if (response.statusCode == 201) {
      // Clear the cart after successful checkout
      foodStore.cart.clear();

      // Navigate to the success screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CheckoutPage()),
      );
    } else {
      // Handle the error (optional)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Checkout failed. Please try again.'),
      ));
    }
  }
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final foodStore = Provider.of<FoodStore>(context);
    return Scaffold(
      appBar:AppBar(
        title: Text('Cart'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart_checkout_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutPage()),
              );
            },
          )
        ],
      ),
      body: Observer(
        builder:(_){
          if (foodStore.cart.isEmpty){
            return Center(child: Text('Cart is Empty'),);
          }
          return ListView.builder(
            itemCount: foodStore.cart.length,
              itemBuilder: (context,index){
                final food = foodStore.cart[index];
                return  Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImage(context, food),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.title,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: IconButton(
                            //     icon: Icon(Icons.add_shopping_cart),
                            //     onPressed: () {
                            //       foodStore.addToCart(food);
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        }
      ),
    );
  }
  Widget _buildImage(BuildContext context, Food food) {
    return FutureBuilder(
      future: Connectivity().checkConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
            return Image.network(
              food.thumbnailUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                if (food.localImagePath != null && food.localImagePath!.isNotEmpty) {
                  return Image.file(
                    File(food.localImagePath!),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Container(height: 150, color: Colors.grey);
                }
              },
            );
          } else if (food.localImagePath != null && food.localImagePath!.isNotEmpty) {
            return Image.file(
              File(food.localImagePath!),
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          } else {
            return Container(height: 150, color: Colors.grey);
          }
        } else {
          return Container(height: 150, color: Colors.grey);
        }
      },
    );
  }
}
