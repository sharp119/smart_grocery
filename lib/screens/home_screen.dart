import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../components/item_card.dart';
import '../models/models.dart';
import 'add_item_screen.dart';
import 'inventory_screen.dart';
import 'recipes_screen.dart';
import 'item_details_screen.dart';
import 'settings_screen.dart';
import 'dart:math';
import '../models/models.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _recentItems = List.generate(
    5,
    (index) => {
      'name': _getRandomFoodItem(),
      'quantity': Random().nextInt(5) + 1,
      'freshnessLevel': FreshnessLevel.values[Random().nextInt(3)],
      'expiryDate': DateTime.now().add(Duration(days: Random().nextInt(14))),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Food Inventory',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverviewSection(context),
              const SizedBox(height: 24),
              _buildQuickAccessSection(context),
              const SizedBox(height: 24),
              _buildRecentItemsSection(context),
            ],
          ),
        ),
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

  Widget _buildOverviewSection(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Inventory Overview',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildOverviewItem(context, 'Fresh', 15, Colors.green),
                _buildOverviewItem(context, 'Medium', 5, Colors.orange),
                _buildOverviewItem(context, 'Expiring Soon', 2, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem(
      BuildContext context, String label, int count, Color color) {
    return Column(
      children: [
        Text(count.toString(),
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: color)),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildQuickAccessSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Access', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQuickAccessItem(context, Icons.list_alt, 'Inventory', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InventoryScreen()),
              );
            }),
            _buildQuickAccessItem(context, Icons.restaurant_menu, 'Recipes',
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipesScreen()),
              );
            }),
            _buildQuickAccessItem(context, Icons.settings, 'Settings', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessItem(BuildContext context, IconData icon,
      String label, VoidCallback onPressed) {
    return Column(
      children: [
        FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          child: Icon(icon),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildRecentItemsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Items', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentItems.length,
          itemBuilder: (context, index) {
            final item = _recentItems[index];
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
      ],
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
