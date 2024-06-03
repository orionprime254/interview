import 'dart:io';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/food_model.dart';
import '../model/food_store.dart';

class FoodCard extends StatelessWidget {
  final Food food;

  FoodCard({required this.food});

  @override
  Widget build(BuildContext context) {
    final foodStore = Provider.of<FoodStore>(context);

    return Card(
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
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      foodStore.addToCart(food);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
