import 'package:flutter/material.dart';

class FreshnessIndicator extends StatelessWidget {
  final DateTime expiryDate;

  const FreshnessIndicator({Key? key, required this.expiryDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daysUntilExpiry = expiryDate.difference(DateTime.now()).inDays;
    Color indicatorColor;

    if (daysUntilExpiry > 7) {
      indicatorColor = Theme.of(context).colorScheme.primary;
    } else if (daysUntilExpiry > 2) {
      indicatorColor = Theme.of(context).colorScheme.tertiary;
    } else {
      indicatorColor = Theme.of(context).colorScheme.error;
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
