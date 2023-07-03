import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nha_gia_re/core/extensions/string_ex.dart';
import '../models/province.dart';

class GoogleMapService {
  void test() async {
    // ham nay demo test thu
    Placemark? placemark = await GoogleMapService.getAddressFromLocation(
        "15.582282", "108.522051");
    if (placemark != null) {
      GoogleMapService.getProvinceByName(placemark.administrativeArea!);
      GoogleMapService.getDistrictByName(placemark.locality!);
    }
  }

  static Future<Placemark?> getAddressFromLocation(
      String lat, String lon) async {
    Placemark? placemark;

    // converted the lat from string to double
    double latData = double.parse(lat);
    // converted the lon from string to double
    double lonData = double.parse(lon);

    // Passed the coordinates of latitude and longitude
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latData, lonData);

    if (placemarks.isNotEmpty) {
      placemark = placemarks[0];

      log("Name ${placemark.name!}");
      log("street ${placemark.street!}");
      log("isoCountryCode ${placemark.isoCountryCode!}");
      log("isoCountryCode ${placemark.isoCountryCode!}");
      log("postalCode ${placemark.postalCode!}");
      log("administrativeArea ${placemark.administrativeArea!}");
      log("subAdministrativeArea ${placemark.subAdministrativeArea!}");
      log("locality ${placemark.locality!}");
      log("subLocality ${placemark.subLocality!}");
      log("thoroughfare ${placemark.thoroughfare!}");
      log("subThoroughfare ${placemark.subThoroughfare!}");
    } else {
      log("Google map rong");
    }

    return placemark;
  }

  static Future<Province?> getProvinceByName(String name) async {
    Province? province = Province();
    final url =
        Uri.parse('https://provinces.open-api.vn/api/p/search/?q=$name');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final datas =
            await jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

        if (datas is List<dynamic>) {
          for (var data in datas) {
            String nameGet = data['name'];
            if (nameGet
                .toLowerCase()
                .noAccentVietnamese()
                .contains(name.toLowerCase().noAccentVietnamese())) {
              province.name = data['name'];
              province.code = data['code'];
              break;
            }
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    log("===================================");
    log("name: ${province.name}");
    log("code: ${province.code}");
    return province;
  }

  static Future<District?> getDistrictByName(String name) async {
    District? district = District();
    final url =
        Uri.parse('https://provinces.open-api.vn/api/d/search/?q=$name');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final datas =
            await jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

        if (datas is List<dynamic>) {
          for (var data in datas) {
            String nameGet = data['name'];
            if (nameGet
                .toLowerCase()
                .noAccentVietnamese()
                .contains(name.toLowerCase().noAccentVietnamese())) {
              district.name = data['name'];
              district.code = data['code'];
              break;
            }
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    log("===================================");
    log("name: ${district.name}");
    log("code: ${district.code}");
    return district;
  }

  static Future<Ward?> getWardByName(String name) async {
    Ward? ward = Ward();
    final url =
        Uri.parse('https://provinces.open-api.vn/api/w/search/?q=$name');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final datas =
            await jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

        if (datas is List<dynamic>) {
          for (var data in datas) {
            String nameGet = data['name'];
            if (nameGet
                .toLowerCase()
                .noAccentVietnamese()
                .contains(name.toLowerCase().noAccentVietnamese())) {
              ward.name = data['name'];
              ward.code = data['code'];
              break;
            }
          }
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    log("===================================");
    log("name: ${ward.name}");
    log("code: ${ward.code}");
    return ward;
  }
}
