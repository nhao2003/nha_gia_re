import 'package:nha_gia_re/data/providers/remote/request/post_request.dart';

import '../../../enums/property_enums.dart';
import '../../../models/address.dart';

class ApartmentRequest extends PostRequest {
  bool isCorner;
  bool isHandOver;
  int? numOfBedRooms;
  Direction? balconyDirection;
  Direction? mainDoorDirection;
  int? numOfToilets;
  String? block;
  int floor;
  ApartmentType? apartmentType;
  LegalDocumentStatus? legalDocumentStatus;
  FurnitureStatus? furnitureStatus;
  ApartmentRequest({
    required this.furnitureStatus,
    required double area,
    required String? projectName,
    required this.apartmentType,
    required this.isCorner,
    required this.isHandOver,
    required this.numOfBedRooms,
    required this.balconyDirection,
    required this.mainDoorDirection,
    required this.numOfToilets,
    required this.block,
    required this.legalDocumentStatus,
    required this.floor,
    required Address address,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required List<String> imagesUrl,
    required bool isProSeller,
    required int? deposit,
  })  : assert(numOfBedRooms == null || numOfBedRooms >= 0),
        assert(numOfToilets == null || numOfToilets >= 0),
        assert(block == null || block.trim().isNotEmpty),
        assert(floor >= 0),
        super(
        area: area,
        type: PropertyType.apartment,
        address: address,
        userID: userID,
        isLease: isLease,
        price: price,
        title: title,
        description: description,
        imagesUrl: imagesUrl,
        isProSeller: isProSeller,
        projectName: projectName,
        deposit: deposit,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'is_corner': isCorner,
      'is_hand_over': isHandOver,
      'num_of_bedrooms': numOfBedRooms,
      'balcony_direction': balconyDirection?.toString(),
      'main_door_direction': mainDoorDirection?.toString(),
      'num_of_toilets': numOfToilets,
      'block': block,
      'floor': floor,
      'apartment_type': apartmentType?.toString(),
      'legal_document_status': legalDocumentStatus?.toString(),
      'furniture_status': furnitureStatus?.toString(),
      ...super.toJson()
    };
  }
}
