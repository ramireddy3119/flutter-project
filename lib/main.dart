import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app_project/screen/home_page.dart';
import 'package:food_app_project/services/cart_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartService(),
      child: MaterialApp(
        title: 'Recipe App',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: HomePage(),
      ),
    );
  }
}
