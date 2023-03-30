abstract class Property {
  String id;
  String? interiorStatus;
  int area;
  String? projectName;

  Property({
    required this.id,
    this.interiorStatus,
    required this.area,
    this.projectName,
  })  : assert(id.isNotEmpty),
        assert(area >= 0),
        assert(interiorStatus == null || interiorStatus.isNotEmpty),
        assert(projectName == null || projectName.isNotEmpty);
}

class Apartment extends Property {
  bool isCorner;
  bool isHandOver;
  String? typeOfApartment;
  int? numOfBedRooms;
  String? balconyDirection;
  String? mainDoorDirection;
  int? numOfToilets;
  String? block;
  int floor;

  Apartment({
    required String id,
    String? interiorStatus,
    required int area,
    String? projectName,
    this.isCorner = false,
    this.isHandOver = false,
    this.typeOfApartment,
    this.numOfBedRooms,
    this.balconyDirection,
    this.mainDoorDirection,
    this.numOfToilets,
    this.block,
    required this.floor,
  })  : assert(typeOfApartment == null || typeOfApartment.isNotEmpty),
        assert(numOfBedRooms == null || numOfBedRooms >= 0),
        assert(balconyDirection == null || balconyDirection.isNotEmpty),
        assert(mainDoorDirection == null || mainDoorDirection.isNotEmpty),
        assert(numOfToilets == null || numOfToilets >= 0),
        assert(block == null || block.isNotEmpty),
        assert(floor >= 0),
        super(
          id: id,
          interiorStatus: interiorStatus,
          area: area,
          projectName: projectName,
        );
}

class House extends Property {
  bool hasWideAlley;
  bool isFacade;
  int? areaUsed;
  String? houseType;
  double? width;
  double? length;
  int? numOfBedRooms;
  int? numOfToilets;
  int? numOfFloors;
  String? mainDoorDirection;
  String? legalStatus;

  House({
    required String id,
    String? interiorStatus,
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
    this.legalStatus,
  })  : assert(areaUsed == null || areaUsed >= 0),
        assert((width == null && length == null) ||
            (width != null && length != null && width * length > 0)),
        assert(houseType == null || houseType.isNotEmpty),
        assert(numOfBedRooms == null || numOfBedRooms >= 0),
        assert(mainDoorDirection == null || mainDoorDirection.isNotEmpty),
        assert(numOfToilets == null || numOfToilets >= 0),
        assert(legalStatus == null || legalStatus.isNotEmpty),
        assert(numOfFloors == null || numOfFloors >= 0),
        super(
          id: id,
          interiorStatus: interiorStatus,
          area: area,
          projectName: projectName,
        );
}

class Land extends Property {
  String? landLotCode;
  String? subdivisionName;
  String? landType;
  double width;
  double length;
  String? landDirection;
  String? legalStatus;
  bool isFacade;
  bool isWidensTowardsTheBack;
  bool hasWideAlley;

  Land({
    required String id,
    String? interiorStatus,
    required int area,
    String? projectName,
    this.landLotCode,
    this.subdivisionName,
    this.landType,
    required this.width,
    required this.length,
    this.landDirection,
    this.legalStatus,
    this.isFacade = false,
    this.isWidensTowardsTheBack = false,
    this.hasWideAlley = false,
  })  : assert(landLotCode == null || landLotCode.isNotEmpty),
        assert(width * length > 0),
        assert(subdivisionName == null || subdivisionName.isNotEmpty),
        assert(landDirection == null || landDirection.isNotEmpty),
        assert(landType == null || landType.isNotEmpty),
        assert(legalStatus == null || legalStatus.isNotEmpty),
        super(
          id: id,
          interiorStatus: interiorStatus,
          area: area,
          projectName: projectName,
        );
}

class Motel extends Property {
  int? electricPrice;
  int? waterPrice;

  Motel({
    required String id,
    String? interiorStatus,
    required int area,
    String? projectName,
    this.electricPrice,
    this.waterPrice,
  })  : assert(electricPrice == null || electricPrice > 0),
        assert(waterPrice == null || waterPrice > 0),
        super(
          id: id,
          interiorStatus: interiorStatus,
          area: area,
          projectName: projectName,
        );
}

class Office extends Property {
  bool hasWideAlley;
  bool isFacade;
  String? officeType;
  String? mainDoorDirection;
  String? legalStatus;

  Office({
    required String id,
    String? interiorStatus,
    required int area,
    String? projectName,
    this.hasWideAlley = false,
    this.isFacade = false,
    this.officeType,
    this.mainDoorDirection,
    this.legalStatus,
  })  : assert(officeType == null || officeType.isNotEmpty),
        assert(mainDoorDirection == null || mainDoorDirection.isNotEmpty),
        assert(legalStatus == null || legalStatus.isNotEmpty),
        super(
          id: id,
          interiorStatus: interiorStatus,
          area: area,
          projectName: projectName,
        );
}
