// lib/models/models.dart

enum FreshnessLevel { fresh, medium, expiringSoon }

class InventoryItem {
  final String name;
  final int quantity;
  final DateTime expiryDate;
  final FreshnessLevel freshnessLevel;

  InventoryItem({
    required this.name,
    required this.quantity,
    required this.expiryDate,
    required this.freshnessLevel,
  });
}

class Recipe {
  final String name;
  final List<String> ingredients;
  final String instructions;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
  });
}

class UserProfile {
  String name;
  String email;
  String phoneNumber;
  String? avatarUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.avatarUrl,
  });
}

class PurchaseHistoryItem {
  final DateTime date;
  final List<String> items;

  PurchaseHistoryItem({
    required this.date,
    required this.items,
  });
}
