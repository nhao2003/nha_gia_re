import '../../../models/address.dart';

class UpdateProfileRequest {
  Address address;
  bool isMale;
  String avatarUrl;
  String fullName;
  String phoneNumber;
  DateTime dob;
  String description;

  UpdateProfileRequest.name({
    required this.address,
    required this.isMale,
    required this.avatarUrl,
    required this.fullName,
    required this.phoneNumber,
    required this.dob,
    required this.description,
  }): assert(avatarUrl.isNotEmpty),
        assert(fullName.isNotEmpty),
        assert( phoneNumber.isNotEmpty),
        assert(description.isNotEmpty);

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'is_male': isMale,
      'avatar_url': avatarUrl,
      'full_name': fullName,
      'phone': phoneNumber,
      'dob': dob.toIso8601String(),
      'description': description,
    };
  }
}
