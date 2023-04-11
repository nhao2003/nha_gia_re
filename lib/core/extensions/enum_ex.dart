import 'package:nha_gia_re/data/enums/property_enums.dart';

extension StringToValue on PropertyType {
  PropertyType? stringToValue(String? value) {
    for (PropertyType type in PropertyType.values) {
      if (type.toString() == value) return type;
    }
    return null;
  }
}
