import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nha_gia_re/core/extensions/string_ex.dart';
import '../models/province.dart';

class GoogleMapService {
  static void test() async {
    // ham nay demo test thu
    Placemark? placemark = await GoogleMapService.getAddressFromLocation(const LatLng(15.582282, 108.522051));
    if (placemark != null) {
      final pro = GoogleMapService.getProvinceByName(placemark.administrativeArea!);
      final dis = GoogleMapService.getDistrictByName(placemark.locality!);
      print(pro.toString());
      print(dis.toString());
    }
  }

  static Future<Placemark?> getAddressFromLocation(LatLng pos) async {
    Placemark? placeMark;
    // Passed the coordinates of latitude and longitude
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placemarks.isNotEmpty) {
      placeMark = placemarks[0];
      log(placeMark.toString());
    } else {
      log("getAddressFromLocation() get Null");
    }
    return placeMark;
  }

  static Future<Province?> getProvinceByName(String name) async {
    Province? province = Province();
    final url =
        Uri.parse('https://provinces.open-api.vn/api/p/search/?q=$name');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data =
            await jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

        if (data is List<dynamic>) {
          for (var data in data) {
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
      log('Error: $e');
    }
    log(province.toString());
    return province;
  }

  static Future<District?> getDistrictByName(String name) async {
    District? district = District();
    final url =
        Uri.parse('https://provinces.open-api.vn/api/d/search/?q=$name');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data =
            await jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

        if (data is List<dynamic>) {
          for (var data in data) {
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
      log('Error: $e');
    }
    log(district.toString());
    return district;
  }

  static Future<Ward?> getWardByName(String name) async {
    Ward? ward = Ward();
    final url =
        Uri.parse('https://provinces.open-api.vn/api/w/search/?q=$name');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data =
            await jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

        if (data is List<dynamic>) {
          for (var data in data) {
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
    log(ward.toString());
    return ward;
  }
}
