class Transaction {
  String id;
  String appTransId;
  bool isSuccess;
  DateTime timeStamp;
  String membershipPackageId;
  String? discountId;
  int amount;
  String userId;
  int numOfSubscriptionMonth;
  static List<Transaction> generateFakeData() {
    List<Transaction> fakeData = [];

    fakeData.add(
      Transaction(
        id: '1',
        appTransId: 'trans_id_1',
        isSuccess: true,
        amount: 100000,
        timeStamp: DateTime.now(),
        membershipPackageId: 'package_id_1',
        discountId: 'discount_id_1',
        userId: 'user_id_1',
        numOfSubscriptionMonth: 1,
      ),
    );

    fakeData.add(
      Transaction(
        id: '2',
        appTransId: 'trans_id_2',
        isSuccess: false,
        amount: 100000,
        timeStamp: DateTime.now(),
        membershipPackageId: 'package_id_2',
        discountId: null,
        userId: 'user_id_2',
        numOfSubscriptionMonth: 3,
      ),
    );

    fakeData.add(
      Transaction(
        id: '3',
        appTransId: 'trans_id_3',
        isSuccess: true,
        amount: 100000,
        timeStamp: DateTime.now(),
        membershipPackageId: 'package_id_3',
        discountId: 'discount_id_3',
        userId: 'user_id_3',
        numOfSubscriptionMonth: 6,
      ),
    );

    // Thêm dữ liệu giả định khác theo nhu cầu của bạn...

    return fakeData;
  }

  Transaction({
    required this.id,
    required this.appTransId,
    required this.isSuccess,
    required this.timeStamp,
    required this.membershipPackageId,
    required this.discountId,
    required this.userId,
    required this.numOfSubscriptionMonth,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      appTransId: json['app_trans_id'] as String,
      amount: json['amount'] as int,
      isSuccess: json['is_success'] as bool,
      timeStamp: DateTime.parse(json['time_stamp']),
      membershipPackageId: json['membership_package_id'] as String,
      discountId: json['discount_id'] as String?,
      userId: json['user_id'] as String,
      numOfSubscriptionMonth: json['num_of_subscription_month'] as int,
    );
  }
}
