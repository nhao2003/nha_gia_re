import 'package:nha_gia_re/data/models/address.dart';

import 'post.dart';

class Motel extends Post {
  int? electricPrice;
  int? waterPrice;
  FurnitureStatus? furnitureStatus;
  Motel({
    required String id,
    this.furnitureStatus,
    required double area,
    String? projectName,
    this.electricPrice,
    this.waterPrice,
    required Address address,
    required PropertyType type,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required DateTime postedAt,
    required DateTime expiryDate,
    required List<String> imagesUrl,
    required bool isProSeller,
    int? deposit,
    int numOfFavs = 0,
  })  : assert(electricPrice == null || electricPrice > 0),
        assert(waterPrice == null || waterPrice > 0),
        super(
          id: id,
          area: area,
          type: type,
          address: address,
          userID: userID,
          isLease: isLease,
          price: price,
          title: title,
          description: description,
          postedAt: postedAt,
          expiryDate: expiryDate,
          imagesUrl: imagesUrl,
          isProSeller: isProSeller,
          projectName: projectName,
          deposit: deposit,
          numOfFavs: numOfFavs,
        );
}
