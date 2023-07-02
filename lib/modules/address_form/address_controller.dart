import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/models/province.dart';

class AddressController extends GetxController{
  AddressController();

  Future<void> getProvince() async{
    final response = await http.get(Uri.parse('https://provinces.open-api.vn/api/?depth=3'));
    print(response.statusCode);
    if(response.statusCode == 200){
      print("200 ok");
      provinceList = [];
      final List<dynamic> data = json.decode(response.body);
      provinceList = data.map((json) => Province.fromJson(json)).toList();
      print("So luong " + provinceList.length.toString());
      update();
    }
    else {
      print("Fail");
    }
    //selectedDistrict = 8;
    // selectedDistrict=73;
    // selectedWard = 2311;
    //setProvince(8);
    //setProvince(8);

    //selectedDistrict = 10;
  }

  final formkey = GlobalKey<FormState>();

  Future<void> setProvince(Province? value) async {
    selectedProvince = value;
    selectedDistrict = null;
    selectedWard = null;
    districtsList = value?.districts != null ?(value?.districts as List<District?>): <District>[];
    districtsList.add(District());
    wardsList = <Ward?>[Ward()];
    update();
  }
  void setDistrict(District? value){
    selectedDistrict = value;
    selectedWard = null;
    wardsList= value?.wards != null ? value?.wards as List<Ward?> : <Ward?>[];
    wardsList.add(Ward());
    update();
  }
  void setWards(Ward? value){
    selectedWard = value;
    update();
  }
  void submitHandler()
  {
    if(formkey.currentState!.validate()){
      print("Press on submit address");
      Address address = Address(
        cityCode: (selectedProvince!.code != null ? selectedProvince!.code! : 0), 
        districtCode: (selectedDistrict!.code != null ? selectedDistrict!.code! : 0) , 
        wardCode: (selectedWard!.code!) ,);
      Get.back(result: address);
    }
  }
  List<Province?> provinceList = [];
  List<District?> districtsList = [District()];
  List<Ward?> wardsList = [Ward()];
  late Address address;
  Province? selectedProvince;
  District? selectedDistrict;
  Ward? selectedWard;
  
}