import 'package:http/http.dart' as http;

class Address {
  late int cityCode;
  late String cityName;
  late int districtCode;
  late String districtName;
  late int wardCode;
  late String wardName;
  late String? detail;
  late double? latitude;
  late double? longitude;
  Address({
    required this.cityCode,
    required this.cityName,
    required this.districtCode,
    required this.districtName,
    required this.wardCode,
    required this.wardName,
    this.detail,
    this.latitude,
    this.longitude,
  })  : assert(detail?.trim().isNotEmpty ?? true),
        assert((longitude == null) == (latitude == null)),
        assert(longitude == null || (-180 <= longitude && longitude <= 180)),
        assert(latitude == null || (-90 <= latitude && latitude <= 90));

  Map<String, dynamic> toJson() => {
        'city_code': cityCode,
        'city_name': cityName,
        'district_code': districtCode,
        'district_name' : districtName,
        'ward_code': wardCode,
        'ward_name' : wardName,
        'detail': detail,
        'latitude': latitude,
        'longitude': longitude,
      };
  @override
  String toString() {
    return '${wardName}, ${districtName}, ${cityName}';
  }
  Address.fromJson(Map<String, dynamic> json)
      : cityCode = json['city_code'],
        cityName = json['city_name'],
        districtCode = json['district_code'],
        districtName = json['district_name'],
        wardCode = json['ward_code'],
        wardName = json['ward_name'],
        detail = json['detail'],
        latitude = json['latitude'],
        longitude = json['longitude'];
}
