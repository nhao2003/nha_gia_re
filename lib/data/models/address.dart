class Address {
  late int cityCode;
  late int districtCode;
  late int wardCode;
  late String? detail;
  late double? latitude;
  late double? longitude;
  Address({
    required this.cityCode,
    required this.districtCode,
    required this.wardCode,
    this.detail,
    this.latitude,
    this.longitude,
  })  : assert(detail?.trim().isNotEmpty ?? true),
        assert((longitude == null) == (latitude == null)),
        assert(longitude == null || (-180 <= longitude && longitude <= 180)),
        assert(latitude == null || (-90 <= latitude && latitude <= 90));

  Map<String, dynamic> toJson() => {
        'city_code': cityCode,
        'district_code': districtCode,
        'ward_code': wardCode,
        'detail': detail,
        'latitude': latitude,
        'longitude': longitude,
      };

  Address.fromJson(Map<String, dynamic> json)
      : cityCode = json['city_code'],
        districtCode = json['district_code'],
        wardCode = json['ward_code'],
        detail = json['detail'],
        latitude = json['latitude'],
        longitude = json['longitude'];
}
