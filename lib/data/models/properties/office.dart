import 'package:nha_gia_re/data/models/address.dart';

import 'post.dart';

class Office extends Post {
  bool hasWideAlley;
  bool isFacade;
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
    this.hasWideAlley = false,
    this.isFacade = false,
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
  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'],
      area: json['area'],
      type: PropertyType.values[json['type']],
      address: Address.fromJson(json['address']),
      userID: json['userID'],
      isLease: json['isLease'],
      price: json['price'],
      title: json['title'],
      description: json['description'],
      postedAt: DateTime.parse(json['postedAt']),
      expiryDate: DateTime.parse(json['expiryDate']),
      imagesUrl: List<String>.from(json['imagesUrl']),
      isProSeller: json['isProSeller'],
      projectName: json['projectName'],
      deposit: json['deposit'],
      numOfFavs: json['numOfFavs'],
      hasWideAlley: json['hasWideAlley'],
      isFacade: json['isFacade'],
      officeType: json['officeType'] != null
          ? OfficeType.values[json['officeType']]
          : null,
      mainDoorDirection: json['mainDoorDirection'] != null
          ? Direction.values[json['mainDoorDirection']]
          : null,
      legalDocumentStatus: json['legalDocumentStatus'] != null
          ? LegalDocumentStatus.values[json['legalDocumentStatus']]
          : null,
      furnitureStatus: json['furnitureStatus'] != null
          ? FurnitureStatus.values.firstWhere((element) => element.toString() == json['furnitureStatus'])
          : null,
    );
  }
}
