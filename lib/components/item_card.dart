import 'package:flutter/material.dart';
import '../models/models.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final int quantity;
  final FreshnessLevel freshnessLevel;
  final VoidCallback? onTap;

  const ItemCard({
    Key? key,
    required this.name,
    required this.quantity,
    required this.freshnessLevel,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: ListTile(
        leading: _buildFreshnessIndicator(),
        title: Text(name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(
          'Quantity: $quantity',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFreshnessIndicator() {
    Color indicatorColor;
    switch (freshnessLevel) {
      case FreshnessLevel.fresh:
        indicatorColor = Colors.green;
        break;
      case FreshnessLevel.medium:
        indicatorColor = Colors.orange;
        break;
      case FreshnessLevel.expiringSoon:
        indicatorColor = Colors.red;
        break;
    }

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: indicatorColor,
      ),
    );
  }
}
