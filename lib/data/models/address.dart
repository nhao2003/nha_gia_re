class Address {
  late int cityCode;
  late int districtCode;
  late int wardCode;
  late String? detail;
  late int? latitude;
  late int? longitude;
  Address({
    required this.cityCode,
    required this.districtCode,
    required this.wardCode,
    this.detail,
    this.latitude,
    this.longitude,
  }) : assert(detail == null || detail.trim().isNotEmpty);
}
