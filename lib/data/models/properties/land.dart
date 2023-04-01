import 'property.dart';

class Land extends Property {
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
    FurnitureStatus? furnitureStatus,
    required int area,
    String? projectName,
    this.landLotCode,
    this.subdivisionName,
    this.landType,
    required this.width,
    required this.length,
    this.landDirection,
    this.legalDocumentStatus,
    this.isFacade = false,
    this.isWidensTowardsTheBack = false,
    this.hasWideAlley = false,
  })  : assert(landLotCode?.trim().isNotEmpty ?? true),
        assert(width * length > 0),
        assert(subdivisionName?.trim().isNotEmpty ?? true),
        super(
          id: id,
          furnitureStatus: furnitureStatus,
          type: PropertyType.land,
          area: area,
          projectName: projectName,
        );
}
