import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../components/item_card.dart';
import '../models/models.dart';
import 'item_details_screen.dart';
import 'add_item_screen.dart';
import 'dart:math';

class InventoryScreen extends StatelessWidget {
  InventoryScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _demoItems = List.generate(
    20,
    (index) => {
      'name': _getRandomFoodItem(),
      'quantity': Random().nextInt(10) + 1,
      'freshnessLevel': FreshnessLevel.values[Random().nextInt(3)],
      'expiryDate': DateTime.now().add(Duration(days: Random().nextInt(14))),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Inventory'),
      body: ListView.builder(
        itemCount: _demoItems.length,
        itemBuilder: (context, index) {
          final item = _demoItems[index];
          return ItemCard(
            name: item['name'],
            quantity: item['quantity'],
            freshnessLevel: item['freshnessLevel'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailsScreen(
                    name: item['name'],
                    quantity: item['quantity'],
                    freshnessLevel: item['freshnessLevel'],
                    expiryDate: item['expiryDate'],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  static String _getRandomFoodItem() {
    final foodItems = [
      'Apple',
      'Banana',
      'Orange',
      'Milk',
      'Bread',
      'Eggs',
      'Cheese',
      'Chicken',
      'Rice',
      'Pasta',
      'Tomato',
      'Cucumber',
      'Carrot',
      'Onion',
      'Potato',
      'Yogurt',
      'Fish',
      'Beef',
      'Lettuce',
      'Spinach'
    ];
    return foodItems[Random().nextInt(foodItems.length)];
  }
}
