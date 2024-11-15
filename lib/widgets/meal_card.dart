import 'package:flutter/material.dart';
import '../screens/meal_details_screen.dart';
import '../services/cart_service.dart';

class MealCard extends StatelessWidget {
  final dynamic meal;

  MealCard({required this.meal});

  void _addToCart(BuildContext context) {
    CartService().addToCart(meal);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${meal['strMeal']} added to cart')),
    );
  }

  void _viewDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          ListTile(
            leading: Image.network(
              meal['strMealThumb'],
              width: 50,
              fit: BoxFit.cover,
            ),
            title: Text(meal['strMeal']),
            subtitle: Text(meal['strCategory']),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => _viewDetails(context),
                child: Text('View Details'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _addToCart(context),
                child: Text('Add to Cart'),
              ),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
