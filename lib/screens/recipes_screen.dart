import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../models/models.dart';
import 'dart:math';

class RecipesScreen extends StatelessWidget {
  RecipesScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _inventoryItems = List.generate(
    20,
    (index) => {
      'name': _getRandomFoodItem(),
      'quantity': Random().nextInt(5) + 1,
      'expiryDate': DateTime.now().add(Duration(days: Random().nextInt(14))),
    },
  );

  final List<Map<String, dynamic>> _randomRecipes = [
    {'name': 'Spaghetti Carbonara'},
    {'name': 'Chicken Stir Fry'},
    {'name': 'Vegetable Soup'},
    {'name': 'Fruit Salad'},
    {'name': 'Grilled Cheese Sandwich'},
    {'name': 'Omelette'},
  ];

  @override
  Widget build(BuildContext context) {
    _inventoryItems.sort((a, b) => a['expiryDate'].compareTo(b['expiryDate']));

    return Scaffold(
      appBar: const CustomAppBar(title: 'Recipes'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSuggestedRecipes(context),
              const SizedBox(height: 24),
              _buildInventoryList(context),
              const SizedBox(height: 24),
              _buildRandomRecipes(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedRecipes(BuildContext context) {
    final expiringItems = _inventoryItems.where((item) {
      final daysUntilExpiry =
          item['expiryDate'].difference(DateTime.now()).inDays;
      return daysUntilExpiry <= 3;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Suggested Recipes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        if (expiringItems.isEmpty)
          const Text(
              'No items expiring soon. Great job managing your inventory!')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: expiringItems.length,
            itemBuilder: (context, index) {
              final item = expiringItems[index];
              final recipe = _getRandomRecipe(item['name']);
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(4)),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Icon(Icons.restaurant,
                            size: 64, color: Colors.grey[600]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(recipe,
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text(
                              'Uses ${item['name']} (expires in ${_getDaysUntilExpiry(item['expiryDate'])} days)'),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Recipe details for $recipe not implemented yet')),
                              );
                            },
                            child: const Text('View Recipe'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildInventoryList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inventory by Expiry Date',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _inventoryItems.length,
          itemBuilder: (context, index) {
            final item = _inventoryItems[index];
            return ListTile(
              title: Text(item['name']),
              subtitle: Text(
                  'Expires in ${_getDaysUntilExpiry(item['expiryDate'])} days'),
              trailing: Text('Qty: ${item['quantity']}'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRandomRecipes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Explore Random Recipes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _randomRecipes.length,
          itemBuilder: (context, index) {
            final recipe = _randomRecipes[index];
            return Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(4)),
                      child: Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(Icons.restaurant,
                              size: 48, color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe['name'],
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Recipe details for ${recipe['name']} not implemented yet')),
                            );
                          },
                          child: const Text('View'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  String _getRandomRecipe(String ingredient) {
    final recipes = [
      '$ingredient Salad',
      'Roasted $ingredient',
      '$ingredient Soup',
      'Grilled $ingredient',
      '$ingredient Stir Fry',
      '$ingredient Casserole',
    ];
    return recipes[Random().nextInt(recipes.length)];
  }

  int _getDaysUntilExpiry(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays;
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
