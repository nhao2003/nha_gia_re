import '../../../enums/enums.dart';
import '../../../models/address.dart';
export 'apartment_request.dart';
export 'house_request.dart';
export 'land_request.dart';
export 'motel_request.dart';
export 'office_request.dart';

abstract class PostRequest {
  double area;
  String? projectName;
  PropertyType type;
  Address address;
  String userID;
  int price;
  int? deposit;
  bool isLease;
  String title;
  String description;
  List<String> imagesUrl;
  bool isProSeller;
  PostRequest({
    required this.area,
    required this.type,
    required this.address,
    required this.userID,
    required this.isLease,
    required this.price,
    required this.title,
    required this.description,
    required this.imagesUrl,
    required this.isProSeller,
    required this.projectName,
    required this.deposit,
  })  : assert(area >= 0),
        assert(projectName?.trim().isNotEmpty ?? true),
        assert(userID.trim().isNotEmpty),
        assert(price > 0),
        assert(title.trim().isNotEmpty),
        assert(description.trim().isNotEmpty);
  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'project_name': projectName,
      'property_type': type.toString(),
      'address': address.toJson(),
      'user_id': userID,
      'price': price,
      'deposit': deposit,
      'is_lease': isLease,
      'title': title,
      'description': description,
      'images_url': imagesUrl,
      'is_pro_seller': isProSeller,
    };
  }
}










