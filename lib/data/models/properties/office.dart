import 'package:nha_gia_re/data/models/address.dart';

import 'post.dart';

class Office extends Post {
  bool? hasWideAlley;
  bool? isFacade;
  OfficeType? officeType;
  Direction? mainDoorDirection;
  LegalDocumentStatus? legalDocumentStatus;
  FurnitureStatus? furnitureStatus;
  Office({
    this.furnitureStatus,
    required String id,
    required double area,
    required PropertyType type,
    required Address address,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required DateTime postedAt,
    required DateTime expiryDate,
    required List<String> imagesUrl,
    required bool isProSeller,
    String? projectName,
    int? deposit,
    int numOfFavs = 0,
    this.hasWideAlley,
    this.isFacade,
    this.officeType,
    this.mainDoorDirection,
    this.legalDocumentStatus,
  })  : assert(projectName?.trim().isNotEmpty ?? true),
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
