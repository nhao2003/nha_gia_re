import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/models/province.dart';
import 'dart:developer';

import '../../data/models/property.dart';
class ApartmentController extends GetxController{
  ApartmentController();
  bool? isCorner = false;
  List<String> apartmentTypeList = ['Chung cư', 'Duplex', 'Penthouse', 'Căn hộ dịch vụ, mini',
    'Tập thể, cư xá', 'Officetel'
  ];
  void addHostelPost(){

  }
}
class HouseController extends GetxController{

}
class LandController extends GetxController{
  List<String> characterProperty = ['Mặt tiền', 'Nở hậu', 'Hẻm xe hơi'];
}
class HostelController extends GetxController{
  void addHostel(){

  }
}
class OfficeController extends GetxController{

}
class PostController extends GetxController {
  PostController(){
    getProvince();
    init();
  }
  void init(){

  }

  ApartmentController apartmentController = ApartmentController();
  List<Province> provinceList = [];
  List<Districts> districtsList = [];
  List<Wards> wardsList = [];
  var selectedIndex = -1;
  bool isPersonal = true;
  late bool isSale = false;
  late Province selectedProvince;
  late Districts selectedDistricts;
  late Wards selectedWards;
  late String selectedPropertyType;
  late String? selectedPropertyCertificate;
  List<String> directionList = ['Đông', 'Tây', 'Nam', 'Bắc', 'Đông Bắc',
    'Đông Nam', 'Tây Bắc', 'Tây Nam'];
  List<String> iteriorStateList = ['Nội thất cao cấp', 'Nội thất đầy đủ', 'Hoàn thiện cơ bản',
    'Bàn giao thô'];
  List<String> propertyTypeList = ['Văn phòng, Mặt bằng kinh doanh', 'Đất', 'Nhà ở', 'Phòng trọ'
    , 'Căn hộ/Chung cư'];
  List<String> propertyCertificate = ['Đã có sổ', 'Đang chờ sổ', 'Giấy tờ khác'];
  void initBody(){
    isPersonal = true;
  }
  void setVisibility(int value){
    selectedIndex = value;
    initBody();
    if(selectedIndex != 3){
      isSale = true;
    }
    else {
      isSale = false;
    }
    update();
  }
  void setRole(bool value){
    isPersonal = value;
    update();
  }
  void setWork(bool value){
    isSale = value;
    update();
  }
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
  }
  void setProvince(Province value){
    selectedProvince = value;
    districtsList =  selectedProvince.districts!;
    update();
  }
  void setDistrict(Districts value){
    selectedDistricts = value;
    wardsList = selectedDistricts.wards!;
    update();
  }
  void setWards(Wards value){
    selectedWards = value;
    update();
  }
  void addPost(Property property){

  }
}
