import 'package:flutter/material.dart';

class CartService with ChangeNotifier {
  final List<dynamic> _cartItems = [];

  List<dynamic> get cartItems => _cartItems;

  void addToCart(dynamic meal) {
    _cartItems.add(meal);
    notifyListeners();
  }

  void removeFromCart(dynamic meal) {
    _cartItems.remove(meal);
    notifyListeners();
  }
}
