import '../../../enums/property_enums.dart';
import '../../../models/address.dart';

abstract class PostRequest {
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
  List<String> imagesUrl;
  bool isProSeller;
  PostRequest({
    required this.area,
    required this.type,
    required this.address,
    required this.userID,
    required this.isLease,
    required this.price,
    required this.title,
    required this.description,
    required this.imagesUrl,
    required this.isProSeller,
    required this.projectName,
    required this.deposit,
  })  : assert(area >= 0),
        assert(projectName?.trim().isNotEmpty ?? true),
        assert(userID.trim().isNotEmpty),
        assert(price > 0),
        assert(title.trim().isNotEmpty),
        assert(description.trim().isNotEmpty);
  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'project_name': projectName,
      'property_type': type.toString(),
      'address': address.toJson(),
      'user_id': userID,
      'price': price,
      'deposit': deposit,
      'is_lease': isLease,
      'title': title,
      'description': description,
      'images_url': imagesUrl,
      'is_pro_seller': isProSeller,
    };
  }
}

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
    required PropertyType type,
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
          type: type,
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
    required Address address,
    required PropertyType type,
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
          type: type,
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
      'numOf_bed_rooms': numOfBedRooms,
      'num_of_toilets': numOfToilets,
      'num_of_floors': numOfFloors,
      'main_door_direction': mainDoorDirection?.toString(),
      'legal_document_status': legalDocumentStatus?.toString(),
      'furniture_status': furnitureStatus?.toString(),
      ...super.toJson(),
    };
  }
}

class LandRequest extends PostRequest {
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
  LandRequest({
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
    required List<String> imagesUrl,
    required bool isProSeller,
    required int? deposit,
  })  : assert(landLotCode?.trim().isNotEmpty ?? true),
        assert(width * length > 0),
        assert(subdivisionName?.trim().isNotEmpty ?? true),
        super(
          area: area,
          type: type,
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
      'land_lot_code': landLotCode,
      'subdivisionName': subdivisionName,
      'landType': landType?.toString().split('.')[1],
      'width': width,
      'length': length,
      'land_direction': landDirection?.toString().split('.')[1],
      'legal_document_status': legalDocumentStatus?.toString().split('.')[1],
      'is_facade': isFacade,
      'is_widens_towards_the_back': isWidensTowardsTheBack,
      'has_wide_alley': hasWideAlley,
      ...super.toJson()
    };
  }
}

class MotelRequest extends PostRequest {
  int? electricPrice;
  int? waterPrice;
  FurnitureStatus? furnitureStatus;
  MotelRequest({
    required this.furnitureStatus,
    required double area,
    required String? projectName,
    required this.electricPrice,
    required this.waterPrice,
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
    required int? deposit,
  })  : assert(electricPrice == null || electricPrice > 0),
        assert(waterPrice == null || waterPrice > 0),
        super(
          area: area,
          type: type,
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
      'electric_price': electricPrice,
      'water_price': waterPrice,
      'furniture_status': furnitureStatus?.toString(),
      ...super.toJson()
    };
  }
}

class OfficeRequest extends PostRequest {
  bool hasWideAlley;
  bool isFacade;
  OfficeType? officeType;
  Direction? mainDoorDirection;
  LegalDocumentStatus? legalDocumentStatus;
  FurnitureStatus? furnitureStatus;
  OfficeRequest({
    required this.furnitureStatus,
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
    required String? projectName,
    required int? deposit,
    required this.hasWideAlley,
    required this.isFacade,
    required this.officeType,
    required this.mainDoorDirection,
    required this.legalDocumentStatus,
  })  : assert(projectName?.trim().isNotEmpty ?? true),
        super(
          area: area,
          type: type,
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
      'office_type': officeType,
      'main_door_direction': mainDoorDirection?.toString(),
      'legal_document_status': legalDocumentStatus?.toString(),
      'furniture_status': furnitureStatus?.toString(),
      ...super.toJson(),
    };
  }
}
