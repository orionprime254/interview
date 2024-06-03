import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/food_store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckoutPage extends StatelessWidget {
  Future<void> _checkout(BuildContext context) async {
    final foodStore = Provider.of<FoodStore>(context, listen: false);

    // Dummy endpoint for the POST request
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'cart': foodStore.cart.map((food) => food.toJson()).toList(),
      }),
    );

    if (response.statusCode == 201) {
      // Clear the cart after successful checkout
      foodStore.cart.clear();

      // Navigate to the success screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SuccessPage()),
      );
    } else {
      // Handle the error (optional)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Checkout failed. Please try again.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Confirm Checkout'),
          onPressed: () => _checkout(context),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Text('Purchase Successful!'),
      ),
    );
  }
}
