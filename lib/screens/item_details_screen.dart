import 'package:flutter/material.dart';
import '../components/custom_app_bar.dart';
import '../components/freshness_indicator.dart';
import '../models/models.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String name;
  final int quantity;
  final FreshnessLevel freshnessLevel;
  final DateTime expiryDate;

  const ItemDetailsScreen({
    Key? key,
    required this.name,
    required this.quantity,
    required this.freshnessLevel,
    required this.expiryDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: name),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemOverview(context),
              const SizedBox(height: 24),
              _buildExpiryInfo(context),
              const SizedBox(height: 24),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemOverview(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                FreshnessIndicator(expiryDate: expiryDate),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Quantity: $quantity',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Freshness: ${_getFreshnessText(freshnessLevel)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpiryInfo(BuildContext context) {
    final daysUntilExpiry = expiryDate.difference(DateTime.now()).inDays;
    final expiryMessage = daysUntilExpiry > 0
        ? 'Expires in $daysUntilExpiry days'
        : 'Expired ${-daysUntilExpiry} days ago';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expiry Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Expiry Date: ${_formatDate(expiryDate)}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 4),
        Text(
          expiryMessage,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: _getExpiryMessageColor(context, daysUntilExpiry),
              ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // TODO: Implement edit functionality
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Edit functionality not implemented yet')),
            );
          },
          icon: const Icon(Icons.edit),
          label: const Text('Edit Item'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () {
            // TODO: Implement delete functionality
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Delete functionality not implemented yet')),
            );
          },
          icon: const Icon(Icons.delete),
          label: const Text('Delete Item'),
        ),
      ],
    );
  }

  String _getFreshnessText(FreshnessLevel level) {
    switch (level) {
      case FreshnessLevel.fresh:
        return 'Fresh';
      case FreshnessLevel.medium:
        return 'Medium';
      case FreshnessLevel.expiringSoon:
        return 'Expiring Soon';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Color _getExpiryMessageColor(BuildContext context, int daysUntilExpiry) {
    if (daysUntilExpiry > 7) {
      return Theme.of(context).colorScheme.primary;
    } else if (daysUntilExpiry > 2) {
      return Theme.of(context).colorScheme.tertiary;
    } else {
      return Theme.of(context).colorScheme.error;
    }
  }
}
