import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../components/freshness_indicator.dart';
import '../components/item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Food Inventory'),
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
          // TODO: Navigate to Add Item Screen
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
                _buildOverviewItem(context, 'Expiring Soon', 5, Colors.orange),
                _buildOverviewItem(context, 'Expired', 2, Colors.red),
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
            _buildQuickAccessItem(context, Icons.list_alt, 'Inventory'),
            _buildQuickAccessItem(context, Icons.restaurant_menu, 'Recipes'),
            _buildQuickAccessItem(context, Icons.settings, 'Settings'),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessItem(
      BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        FilledButton.tonal(
          onPressed: () {
            // TODO: Navigate to respective screen
          },
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
          itemCount: 5, // Show last 5 items
          itemBuilder: (context, index) {
            // TODO: Replace with actual data
            return ItemCard(
              name: 'Item ${index + 1}',
              expiryDate: DateTime.now().add(Duration(days: index * 2)),
              onTap: () {
                // TODO: Navigate to Item Details Screen
              },
            );
          },
        ),
      ],
    );
  }
}
