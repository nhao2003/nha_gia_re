import 'property.dart';

class Motel extends Property {
  int? electricPrice;
  int? waterPrice;

  Motel({
    required String id,
    FurnitureStatus? furnitureStatus,
    required int area,
    String? projectName,
    this.electricPrice,
    this.waterPrice,
  })  : assert(electricPrice == null || electricPrice > 0),
        assert(waterPrice == null || waterPrice > 0),
        super(
          id: id,
          furnitureStatus: furnitureStatus,
          type: PropertyType.motel,
          area: area,
          projectName: projectName,
        );
}
