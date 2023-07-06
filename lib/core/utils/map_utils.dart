import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapUtils {
  static Future<bool> requestLocationService() async {
    Location location = Location();
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return serviceEnabled;
      }
    }
    return serviceEnabled;
  }

  static Future<bool> requestLocationPermission() async {
    Location location = Location();
    PermissionStatus permissionGranted;
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      return permissionGranted == PermissionStatus.granted;
    }
    return permissionGranted == PermissionStatus.granted;
  }

  static String getStaticMapUrl(LatLng latLng, int zoom,
      {int height = 400, int width = 400}) {
    assert(zoom >= 0 && zoom <= 21, 'Invalid zoom level');
    assert(height >= 0 && width >= 0, 'Invalid map size');
    const apiKey =
        'AIzaSyATj_CC4_aSPMod2MfeAmz67Ek2t_rhrwc'; // Thay YOUR_API_KEY bằng API key của bạn
    const baseUrl = 'https://maps.googleapis.com/maps/api/staticmap';
    final center = '${latLng.latitude},${latLng.longitude}';
    const size = '400x400';
    final marker = 'markers=${latLng.latitude},${latLng.longitude}';
    final url =
        '$baseUrl?center=$center&zoom=$zoom&size=$size&$marker&key=$apiKey';
    return url;
  }

  static String buildAddressString({
    required String? name,
    required String? street,
    required String? administrativeArea,
    required String? locality,
    required String? country,
  }) {
    List<String> addressComponents = [];

    if (name != null && name.isNotEmpty) {
      addressComponents.add(name);
    }

    if (street != null && street.isNotEmpty) {
      addressComponents.add(street);
    }

    if (locality != null && locality.isNotEmpty) {
      addressComponents.add(locality);
    }

    if (administrativeArea != null && administrativeArea.isNotEmpty) {
      addressComponents.add(administrativeArea);
    }

    if (country != null && country.isNotEmpty) {
      addressComponents.add(country);
    }
    return addressComponents.join(', ');
  }
}
