class MembershipPackage {
  String id;
  String name;
  String description;
  int price;
  int monthlyPostLimit;
  bool postApprovalPriority;
  bool displayPriority;
  bool customerCarePriority;
  bool showVerifiedBadge;
  bool superFastApproval;
  MembershipPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.monthlyPostLimit,
    required this.postApprovalPriority,
    required this.displayPriority,
    required this.customerCarePriority,
    required this.showVerifiedBadge,
    required this.superFastApproval,
  });
  factory MembershipPackage.fromJson(Map<String, dynamic> json) {
    return MembershipPackage(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      monthlyPostLimit: json['monthlyPostLimit'] as int,
      postApprovalPriority: json['postApprovalPriority'] as bool,
      displayPriority: json['displayPriority'] as bool,
      showVerifiedBadge: json['showVerifiedBadge'] as bool,
      customerCarePriority: json['customerCarePriority'] as bool,
      superFastApproval: json['superFastApproval'] as bool,
    );
  }
  static List<MembershipPackage> createFakeData() {
    return [
      MembershipPackage(
        id: 'basic',
        name: 'Gói cơ bản',
        description: 'Giải pháp tiết kiệm dành cho môi giới mới vào nghề',
        price: 200000,
        monthlyPostLimit: 20,
        postApprovalPriority: false,
        displayPriority: true,
        customerCarePriority: false,
        showVerifiedBadge: false,
        superFastApproval: false,
      ),
      MembershipPackage(
        id: 'pro',
        name: 'Gói chuyên nghiệp',
        description: 'Giải pháp tối ưu cho môi giới chuyên nghiệp',
        price: 400000,
        monthlyPostLimit: 30,
        postApprovalPriority: true,
        displayPriority: true,
        customerCarePriority: false,
        showVerifiedBadge: true,
        superFastApproval: false,
      ),
      MembershipPackage(
        id: 'business',
        name: 'Gói doanh nghiệp',
        description: 'Giải pháp tối ưu và tiết kiệm nhất cho doanh nghiệp',
        price: 600000,
        monthlyPostLimit: 60,
        postApprovalPriority: true,
        displayPriority: true,
        customerCarePriority: true,
        showVerifiedBadge: true,
        superFastApproval: true,
      ),
    ];
  }

}