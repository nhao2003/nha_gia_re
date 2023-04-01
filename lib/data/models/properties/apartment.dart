import 'property.dart';

class Apartment extends Property {
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
  Apartment({
    required String id,
    FurnitureStatus? furnitureStatus,
    required int area,
    String? projectName,
    this.apartmentType,
    this.isCorner = false,
    this.isHandOver = false,
    this.numOfBedRooms,
    this.balconyDirection,
    this.mainDoorDirection,
    this.numOfToilets,
    this.block,
    this.legalDocumentStatus,
    required this.floor,
  })  : assert(numOfBedRooms == null || numOfBedRooms >= 0),
        assert(numOfToilets == null || numOfToilets >= 0),
        assert(block == null || block.trim().isNotEmpty),
        assert(floor >= 0),
        super(
          id: id,
          furnitureStatus: furnitureStatus,
          type: PropertyType.apartment,
          area: area,
          projectName: projectName,
        );
}
