import 'package:nha_gia_re/data/models/address.dart';

import '../../enums/enums.dart';
import 'post.dart';

class Office extends Post {
  bool hasWideAlley;
  bool isFacade;
  OfficeType? officeType;
  Direction? mainDoorDirection;
  LegalDocumentStatus? legalDocumentStatus;
  FurnitureStatus? furnitureStatus;

  Office({
    required this.furnitureStatus,
    required String id,
    required double area,
    required PropertyType type,
    required Address address,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required DateTime postedDate,
    required DateTime expiryDate,
    required List<String> imagesUrl,
    required bool isProSeller,
    required String? projectName,
    required int? deposit,
    required int numOfLikes,
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
          postedDate: postedDate,
          expiryDate: expiryDate,
          imagesUrl: imagesUrl,
          isProSeller: isProSeller,
          projectName: projectName,
          deposit: deposit,
          numOfLikes: numOfLikes,
        );

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json['id'],
      area: json['area'],
      type: PropertyType.parse(json['property_type']),
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
      officeType:
          json['office_type'] != null ? OfficeType.parse(json['office_type']) : null,
      mainDoorDirection: json['main_door_direction'] != null
          ? Direction.parse(json['main_door_direction'])
          : null,
      legalDocumentStatus: json['legal_document_status'] != null
          ? LegalDocumentStatus.parse(json['legal_document_status'])
          : null,
      furnitureStatus: json['furniture_status'] != null
          ? FurnitureStatus.parse(json['furniture_status'])
          : null,
    );
  }
  @override
  String toString() {
    return 'Office{'
        'id: $id, '
        'area: $area, '
        'projectName: $projectName, '
        'type: $type, '
        'address: $address, '
        'userID: $userID, '
        'price: $price, '
        'deposit: $deposit, '
        'isLease: $isLease, '
        'title: $title, '
        'description: $description, '
        'postedDate: $postedDate, '
        'expiryDate: $expiryDate, '
        'numOfLikes: $numOfLikes, '
        'imagesUrl: $imagesUrl, '
        'isProSeller: $isProSeller, '
        'hasWideAlley: $hasWideAlley, '
        'isFacade: $isFacade, '
        'officeType: $officeType, '
        'mainDoorDirection: $mainDoorDirection, '
        'legalDocumentStatus: $legalDocumentStatus, '
        'furnitureStatus: $furnitureStatus'
        '}';
  }
}
