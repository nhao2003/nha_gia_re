import '../../enums/property_enums.dart';
import '../address.dart';

export '../../enums/property_enums.dart';
export 'package:nha_gia_re/data/models/properties/office.dart';
export 'package:nha_gia_re/data/models/properties/apartment.dart';
export 'package:nha_gia_re/data/models/properties/post.dart';
export 'package:nha_gia_re/data/models/properties/house.dart';
export 'package:nha_gia_re/data/models/properties/land.dart';
export 'package:nha_gia_re/data/models/properties/motel.dart';

abstract class Post {
  String id;
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
  DateTime postedAt;
  DateTime expiryDate;
  int numOfFavs;
  List<String> imagesUrl;
  bool isProSeller;

  Post({
    required this.id,
    required this.area,
    required this.type,
    required this.address,
    required this.userID,
    required this.isLease,
    required this.price,
    required this.title,
    required this.description,
    required this.postedAt,
    required this.expiryDate,
    required this.imagesUrl,
    required this.isProSeller,
    this.projectName,
    this.deposit,
    required this.numOfFavs,
  })  : assert(id.trim().isNotEmpty),
        assert(area >= 0),
        assert(projectName?.trim().isNotEmpty ?? true),
        assert(userID.trim().isNotEmpty),
        assert(price > 0),
        assert(title.trim().isNotEmpty),
        assert(description.trim().isNotEmpty),
        assert(postedAt.isBefore(expiryDate)),
        assert(numOfFavs >= 0);
}
