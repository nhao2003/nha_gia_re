import 'property.dart';

class Office extends Property {
  bool hasWideAlley;
  bool isFacade;
  OfficeType? officeType;
  Direction? mainDoorDirection;
  LegalDocumentStatus? legalDocumentStatus;

  Office({
    required String id,
    FurnitureStatus? furnitureStatus,
    required int area,
    String? projectName,
    this.hasWideAlley = false,
    this.isFacade = false,
    this.officeType,
    this.mainDoorDirection,
    this.legalDocumentStatus,
  })  : assert(projectName?.trim().isNotEmpty ?? true),
        super(
          id: id,
          furnitureStatus: furnitureStatus,
          type: PropertyType.office,
          area: area,
          projectName: projectName,
        );
}
