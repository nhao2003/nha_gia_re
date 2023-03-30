import 'address.dart';

class UserInfo {
  String uid;
  bool isMale;
  String? avatarUrl;
  List<String>? following;
  late Address address;
  String fullName;
  DateTime createdAt;
  String phoneNumber;
  String email;

  late DateTime birthday;
  String? description;

  UserInfo({
    required this.uid,
    required this.isMale,
    required this.address,
    required this.fullName,
    required this.createdAt,
    required this.phoneNumber,
    required this.birthday,
    required this.email,
    this.description,
    this.avatarUrl,
    this.following,
  })  : assert(uid.isNotEmpty),
        assert(avatarUrl == null || avatarUrl.isNotEmpty),
        assert(fullName.isNotEmpty),
        assert(createdAt.isBefore(DateTime.now())),
        assert(phoneNumber.isNotEmpty),
        assert(birthday.isBefore(createdAt)),
        assert(email.isNotEmpty),
        assert(description == null || description.isNotEmpty);
}
