class AccountVerificationRequests {
  String id;
  String userId;
  DateTime requestDate;
  String frontIdentityCardImageLink;
  String backIdentityCardImageLink;
  String portraitImagePath; // anh mat
  String fullName;
  bool sex;
  String dob;
  String identityCardNo; // so cccd
  DateTime identityCardIssuedDate; // ngay cap cccd
  String placeOfOrigin; // que quan
  String placeOfResidence; // dia chi thuong tru

  AccountVerificationRequests({
    required this.id,
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

  factory AccountVerificationRequests.fromJson(Map<String, dynamic> json) {
    return AccountVerificationRequests(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      requestDate: DateTime.parse(json['request_date']),
      frontIdentityCardImageLink:
          json['front_identity_card_image_link'] as String,
      backIdentityCardImageLink:
          json['back_identity_card_image_link'] as String,
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

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'request_date': requestDate.toIso8601String(),
      'front_identity_card_image_link': frontIdentityCardImageLink,
      'back_identity_card_image_link': backIdentityCardImageLink,
      'portrait_image_path': portraitImagePath,
      'full_name': fullName,
      'sex': sex,
      'dob': dob,
      'identity_card_no': identityCardNo,
      'identity_card_issued_date': identityCardIssuedDate.toIso8601String(),
      'place_of_origin': placeOfOrigin,
      'place_of_residence': placeOfResidence,
    };
  }
}
