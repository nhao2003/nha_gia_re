import 'address.dart';

class UserInfo {
  String uid;
  late Address? address;
  bool? isMale;
  String? avatarUrl;
  String? fullName;
  String? phoneNumber;
  String? email;
  DateTime? dob;
  String? description;

  UserInfo({
    required this.uid,
    this.email,
    this.isMale,
    this.address,
    this.fullName,
    this.phoneNumber,
    this.dob,
    this.description,
    this.avatarUrl,
  })  : assert(uid.isNotEmpty),
        assert(avatarUrl == null || avatarUrl.isNotEmpty),
        assert(fullName == null || fullName.isNotEmpty),
        assert(phoneNumber ==null || phoneNumber.isNotEmpty),
        assert(email == null || email.isNotEmpty),
        assert(description == null || description.isNotEmpty);

  UserInfo.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        address = json['address'] != null ? Address.fromJson(json['address']) : null,
        isMale = json['is_male'],
        avatarUrl = json['avatar_url'],
        fullName = json['full_name'],
        phoneNumber = json['phone_number'],
        email = json['email'],
        dob = json['dob'] != null ? DateTime.parse(json['dob']) : null,
        description = json['description'];
}
