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
  DateTime lastActivityAt;
  DateTime? updatedDate;
  int numOfFollowers;
  int numOfFollowings;

  UserInfo({
    required this.uid,
    required this.email,
    required this.isMale,
    required this.address,
    required this.fullName,
    required this.phoneNumber,
    required this.dob,
    required this.description,
    required this.avatarUrl,
    required this.lastActivityAt,
    required this.updatedDate,
    required this.numOfFollowings,
    required this.numOfFollowers,
  })  : assert(uid.isNotEmpty),
        assert(avatarUrl == null || avatarUrl.isNotEmpty),
        assert(fullName == null || fullName.isNotEmpty),
        assert(phoneNumber == null || phoneNumber.isNotEmpty),
        assert(email == null || email.isNotEmpty),
        assert(description == null || description.isNotEmpty);

  UserInfo.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        address =
            json['address'] != null ? Address.fromJson(json['address']) : null,
        isMale = json['is_male'],
        avatarUrl = json['avatar_url'],
        fullName = json['full_name'],
        phoneNumber = json['phone'],
        email = json['email'],
        dob = json['dob'] != null ? DateTime.parse(json['dob']) : null,
        description = json['description'],
        numOfFollowers = json['num_of_followers'],
        numOfFollowings = json['num_of_following'],
        lastActivityAt = DateTime.parse(json['last_activity_at']),
        updatedDate =json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;

  @override
  String toString() {
    return 'UserInfo{uid: $uid, address: $address, isMale: $isMale, avatarUrl: $avatarUrl, fullName: $fullName, phoneNumber: $phoneNumber, email: $email, dob: $dob, description: $description, lastActivityAt: $lastActivityAt, updatedDate: $updatedDate}';
  }
}
