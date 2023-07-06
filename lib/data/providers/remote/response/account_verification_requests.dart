class AccountVerificationResponse {
  String id;
  bool isVerified;
  DateTime reviewedAt;
  String? rejectedInfo;
  String userId;
  DateTime requestDate;
  String frontIdentityCardImageLink;
  String backIdentityCardImageLink;
  String portraitImagePath;
  String fullName;
  bool sex;
  String dob;
  String identityCardNo;
  DateTime identityCardIssuedDate;
  String placeOfOrigin;
  String placeOfResidence;

  AccountVerificationResponse({
    required this.id,
    required this.isVerified,
    required this.reviewedAt,
    required this.rejectedInfo,
    required this.userId,
    required this.requestDate,
    required this.frontIdentityCardImageLink,
    required this.backIdentityCardImageLink,
    required this.portraitImagePath,
    required this.fullName,
    required this.sex,
    required this.dob,
    required this.identityCardNo,
    required this.identityCardIssuedDate,
    required this.placeOfOrigin,
    required this.placeOfResidence,
  });

  factory AccountVerificationResponse.fromJson(Map<String, dynamic> json) {
    return AccountVerificationResponse(
      id: json['id'] as String,
      isVerified: json['is_verified '] as bool,
      reviewedAt: DateTime.parse(json['reviewed_at '] as String),
      rejectedInfo: json['rejectedInfo '] as String,
      userId: json['user_id'] as String,
      requestDate: DateTime.parse(json['request_date']),
      frontIdentityCardImageLink: json['front_identity_card_image_link'] as String,
      backIdentityCardImageLink: json['back_identity_card_image_link'] as String,
      portraitImagePath: json['portrait_image_path'] as String,
      fullName: json['full_name'] as String,
      sex: json['sex'] as bool,
      dob: json['dob'] as String,
      identityCardNo: json['identity_card_no'] as String,
      identityCardIssuedDate: DateTime.parse(json['identity_card_issued_date']),
      placeOfOrigin: json['place_of_origin'] as String,
      placeOfResidence: json['place_of_residence'] as String,
    );
  }
}
