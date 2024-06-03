import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:interview/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interview/model/food_model.dart';
import 'package:interview/model/food_store.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(FoodAdapter());
  await Hive.openBox<Food>('foodsBox');
  await Hive.openBox<Food>('cartBox');
  runApp(
    MyApp(),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FoodStore>(create: (_)=> FoodStore())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
