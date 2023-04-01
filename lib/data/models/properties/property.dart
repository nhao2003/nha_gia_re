import '../../../core/enums/property_enums.dart';

export '../../../core/enums/property_enums.dart';
export 'package:nha_gia_re/data/models/properties/office.dart';
export 'package:nha_gia_re/data/models/properties/apartment.dart';
export 'package:nha_gia_re/data/models/properties/property.dart';
export 'package:nha_gia_re/data/models/properties/house.dart';
export 'package:nha_gia_re/data/models/properties/land.dart';
export 'package:nha_gia_re/data/models/properties/motel.dart';

abstract class Property {
  String id;
  FurnitureStatus? furnitureStatus;
  int area;
  String? projectName;
  PropertyType type;
  Property({
    required this.id,
    this.furnitureStatus,
    required this.area,
    this.projectName,
    required this.type,
  })  : assert(id.isNotEmpty),
        assert(area >= 0),
        assert(projectName?.trim().isNotEmpty ?? true);
}
