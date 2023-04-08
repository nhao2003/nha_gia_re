import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/models/province.dart';
import 'package:nha_gia_re/modules/post/post_controller.dart';
import 'dart:developer';

import '../../data/models/property.dart';

class PropertyController extends GetxController{
  PropertyController(){
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
  bool isHandover = false;
  late Province? selectedProvince;
  late Districts? selectedDistricts;
  late Wards? selectedWards;
  late String selectedPropertyType;
  late String? selectedPropertyCertificate;
  //post
  String title = "";
  String description = "";
  String area = "";
  String price = "";
  String deposit = "";
  String projectName = "";
  String floor = "";
  String block = "";
  String subdivisionName  = "";
  String landCode = "";
  String numberOfToilet = "";
  String numberOfBedroom = "";

  String usedArea = "" ;
  String height = "";
  String  width = "";
  String address = "";
  //property
  String propertyType = "";
  //character
  bool isFacade = false;
  bool isWidensTowardsTheBack = false;
  bool hasWideAlley = false;
  bool isCorner = false;
  //van phong
  String officeType = "";
  //Dat
  String landType = "";
  String landDirection = "";
  //Can ho
  String apartmentType = "";
  //Nha o
  String houseType = "";
  //

  String directionDoor="";
  String balconyDirection = "";
  String interiorState = "";
  String legalStatus = "";
  List<String> directionList = ['Đông', 'Tây', 'Nam', 'Bắc', 'Đông Bắc',
    'Đông Nam', 'Tây Bắc', 'Tây Nam'];
  List<String> iteriorStateList = ['Nội thất cao cấp', 'Nội thất đầy đủ', 'Hoàn thiện cơ bản',
    'Bàn giao thô'];
  List<String> propertyTypeList = ['Văn phòng, Mặt bằng kinh doanh', 'Đất', 'Nhà ở', 'Phòng trọ'
    , 'Căn hộ/Chung cư'];
  List<String> propertyCertificate = ['Đã có sổ', 'Đang chờ sổ', 'Giấy tờ khác'];
  List<String> apartmentTypeList = ['Chung cư', 'Duplex', 'Penthouse', 'Căn hộ dịch vụ, mini',
  'Tập thể, cư xá', 'Officetel'];
  List<String> landTypeList = ['Đất thổ cư', 'Đất nền dự án', 'Đất nông nghiệp', 'Đất công nghiệp'];
  List<String> houseTypeList = ['Nhà mặt phố, mặt tiền', 'Nhà ngõ, hẻm', 'Nhà biệt thự', 'Nhà liền kề'];
  String addressDisplay = "";
  void setAddress(){
    addressDisplay = selectedProvince!.name.toString() + " " + selectedDistricts!.name.toString() + " " + selectedWards!.name.toString();
    update();
  }
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
  void setHandOver(bool value){
    isHandover = value;
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
    districtsList =  selectedProvince!.districts!;
    selectedDistricts = null;
    selectedWards = null;
    update();
  }
  void setDistrict(Districts value){
    selectedDistricts = value;
    wardsList = selectedDistricts!.wards!;
    selectedWards = null;
    update();
  }
  void setWards(Wards value){
    selectedWards = value;
    update();
  }
  void addPost(Property property){

  }
}