import 'package:nha_gia_re/data/models/property.dart';

import 'address.dart';

class Post {
  late final String id;
  late Address address;
  late final String userID;
  String? propertyID;
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
    this.deposit,
    this.numOfFavs = 0,
    this.propertyID,
  })  : assert((isLease == false && deposit == null) ||
            (isLease == true && deposit != null && deposit > 0)),
        assert(id.trim().isNotEmpty),
        assert(userID.trim().isNotEmpty),
        assert(price > 0),
        assert(title.trim().isNotEmpty),
        assert(description.trim().isNotEmpty),
        assert(postedAt.isBefore(expiryDate)),
        assert(numOfFavs >= 0);
}
