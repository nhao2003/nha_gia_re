import '../../../enums/enums.dart';
import '../../../models/address.dart';
import 'post_request.dart';

class HouseRequest extends PostRequest {
  bool hasWideAlley;
  bool isFacade;
  double? areaUsed;
  HouseType? houseType;
  double? width;
  double? length;
  int? numOfBedRooms;
  int? numOfToilets;
  int? numOfFloors;
  Direction? mainDoorDirection;
  LegalDocumentStatus? legalDocumentStatus;
  FurnitureStatus? furnitureStatus;
  bool isWidensTowardsTheBack;
  HouseRequest({
    required this.furnitureStatus,
    required double area,
    required String? projectName,
    required this.hasWideAlley,
    required this.isFacade,
    required this.areaUsed,
    required this.width,
    required this.length,
    required this.houseType,
    required this.numOfBedRooms,
    required this.numOfToilets,
    required this.numOfFloors,
    required this.mainDoorDirection,
    required this.legalDocumentStatus,
    required this.isWidensTowardsTheBack,
    required Address address,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required List<String> imagesUrl,
    required bool isProSeller,
    required int? deposit,
  })  : assert(areaUsed == null || areaUsed > 0),
        assert((width == null && length == null) ||
            (width != null && length != null && width * length > 0)),
        assert(numOfBedRooms == null || numOfBedRooms >= 0),
        assert(numOfToilets == null || numOfToilets >= 0),
        assert(numOfFloors == null || numOfFloors >= 0),
        super(
        area: area,
        type: PropertyType.house,
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
      'has_wide_alley': hasWideAlley,
      'is_facade': isFacade,
      'area_used': areaUsed,
      'house_type': houseType?.toString(),
      'width': width,
      'length': length,
      'num_of_bedrooms': numOfBedRooms,
      'num_of_toilets': numOfToilets,
      'num_of_floors': numOfFloors,
      'main_door_direction': mainDoorDirection?.toString(),
      'legal_document_status': legalDocumentStatus?.toString(),
      'furniture_status': furnitureStatus?.toString(),
      'is_widens_towards_the_back': isWidensTowardsTheBack,
      ...super.toJson(),
    };
  }
}
