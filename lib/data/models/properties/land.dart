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
  bool isFacade;
  bool isWidensTowardsTheBack;
  bool hasWideAlley;

  Land({
    required String id,
    required double area,
    required String? projectName,
    required this.landLotCode,
    required this.subdivisionName,
    required this.landType,
    required this.width,
    required this.length,
    required this.landDirection,
    required this.legalDocumentStatus,
    required this.isFacade,
    required this.isWidensTowardsTheBack,
    required this.hasWideAlley,
    required Address address,
    required PropertyType type,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required DateTime postedDate,
    required DateTime expiryDate,
    required List<String> imagesUrl,
    required bool isProSeller,
    required int? deposit,
    required int numOfLikes,
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
          postedDate: postedDate,
          expiryDate: expiryDate,
          imagesUrl: imagesUrl,
          isProSeller: isProSeller,
          projectName: projectName,
          deposit: deposit,
          numOfLikes: numOfLikes,
        );

  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(
      id: json['id'],
      area: json['area'],
      type: PropertyType.values[json['property_type']],
      address: Address.fromJson(json['address']),
      userID: json['user_id'],
      isLease: json['is_lease'],
      price: json['price'],
      title: json['title'],
      description: json['description'],
      postedDate: DateTime.parse(json['posted_date']),
      expiryDate: DateTime.parse(json['expiry_date']),
      imagesUrl: List<String>.from(json['images_url']),
      isProSeller: json['is_pro_seller'],
      projectName: json['project_name'],
      deposit: json['deposit'],
      numOfLikes: json['num_of_likes'],
      hasWideAlley: json['has_wide_alley'],
      isFacade: json['is_facade'],
      landType: json['land_type'] != null ? LandType.parse(json['land_type']) : null,
      landDirection: json['land_direction'] != null
          ? Direction.values[json['land_direction']]
          : null,
      legalDocumentStatus: json['legal_document_status'] != null
          ? LegalDocumentStatus.values[json['legal_document_status']]
          : null,
      width: json['width'],
      length: json['length'],
      landLotCode: json['land_lot_code'],
      subdivisionName: json['subdivision_name'],
      isWidensTowardsTheBack: json['is_widens_towards_the_back'],
    );
  }
}
