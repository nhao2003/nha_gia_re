import 'property.dart';

class House extends Property {
  bool hasWideAlley;
  bool isFacade;
  int? areaUsed;
  HouseType? houseType;
  double? width;
  double? length;
  int? numOfBedRooms;
  int? numOfToilets;
  int? numOfFloors;
  Direction? mainDoorDirection;
  LegalDocumentStatus? legalDocumentStatus;
  House({
    required String id,
    FurnitureStatus? furnitureStatus,
    required int area,
    String? projectName,
    this.hasWideAlley = false,
    this.isFacade = false,
    this.areaUsed,
    this.width,
    this.length,
    this.houseType,
    this.numOfBedRooms,
    this.numOfToilets,
    this.numOfFloors,
    this.mainDoorDirection,
    this.legalDocumentStatus,
  })  : assert(areaUsed == null || areaUsed > 0),
        assert((width == null && length == null) ||
            (width != null && length != null && width * length > 0)),
        assert(numOfBedRooms == null || numOfBedRooms >= 0),
        assert(numOfToilets == null || numOfToilets >= 0),
        assert(numOfFloors == null || numOfFloors >= 0),
        super(
          id: id,
          furnitureStatus: furnitureStatus,
          type: PropertyType.house,
          area: area,
          projectName: projectName,
        );
}
