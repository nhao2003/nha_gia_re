import 'package:nha_gia_re/data/models/address.dart';

import 'post.dart';

class Land extends Post {
  String? landLotCode;
  String? subdivisionName;
  LandType? landType;
  double width;
  double length;
  Direction? landDirection;
  LegalDocumentStatus? legalDocumentStatus;
  bool? isFacade;
  bool? isWidensTowardsTheBack;
  bool? hasWideAlley;
  Land({
    required String id,
    required double area,
    String? projectName,
    this.landLotCode,
    this.subdivisionName,
    this.landType,
    required this.width,
    required this.length,
    this.landDirection,
    this.legalDocumentStatus,
    this.isFacade,
    this.isWidensTowardsTheBack,
    this.hasWideAlley,
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
  })  : assert(landLotCode?.trim().isNotEmpty ?? true),
        assert(width * length > 0),
        assert(subdivisionName?.trim().isNotEmpty ?? true),
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
