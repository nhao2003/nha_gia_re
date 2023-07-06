class Discount {
  final String id;
  final String membershipPackageId;
  final String description;
  final Map<int, int> subscriptionDiscounts;
  final DateTime startDate;
  final DateTime endDate;

  Discount({
    required this.id,
    required this.membershipPackageId,
    required this.description,
    required this.subscriptionDiscounts,
    required this.startDate,
    required this.endDate,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final membershipPackageId = json['membership_package_id'] as String;
    final description = json['description'] as String;
    final subscriptionDiscountsJson = json['subscription_discounts'] as Map<String, dynamic>;
    final subscriptionDiscounts = subscriptionDiscountsJson.map<int, int>(
          (key, value) => MapEntry(int.parse(key), value as int),
    );
    final startDate = DateTime.parse(json['start_date'] as String);
    final endDate = DateTime.parse(json['end_date'] as String);
    return Discount(
      id: id,
      membershipPackageId: membershipPackageId,
      description: description,
      subscriptionDiscounts: subscriptionDiscounts,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

