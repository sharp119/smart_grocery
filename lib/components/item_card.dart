import 'package:flutter/material.dart';
import 'freshness_indicator.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final DateTime expiryDate;
  final VoidCallback onTap;

  const ItemCard({
    Key? key,
    required this.name,
    required this.expiryDate,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: ListTile(
        leading: FreshnessIndicator(expiryDate: expiryDate),
        title: Text(name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(
          'Expires on ${expiryDate.toString().split(' ')[0]}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
