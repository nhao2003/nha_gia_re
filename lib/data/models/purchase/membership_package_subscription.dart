class MembershipPackageSubscription {
  late String id;
  late String transactionId;
  late String membershipPackageId;
  late String userId;
  late DateTime startDate;
  late DateTime endDate;

  MembershipPackageSubscription({
    required this.id,
    required this.transactionId,
    required this.membershipPackageId,
    required this.userId,
    required this.startDate,
    required this.endDate,
  });

  factory MembershipPackageSubscription.fromJson(Map<String, dynamic> json) {
    return MembershipPackageSubscription(
      id: json['id'],
      transactionId: json['transaction_id'],
      membershipPackageId: json['membership_package_id'],
      userId: json['user_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }
}
