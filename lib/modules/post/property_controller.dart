import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/models/province.dart';
import 'dart:developer';
import '../../data/enums/enum.dart';
import '../../data/models/properties/post.dart';

class PropertyController extends GetxController{
  PropertyController();
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
  void deleteImage(int index){
    photo.removeAt(index);
    update();
  }
  List<XFile> photo  = [];
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async{
    final pickedImages = await _picker.pickMultiImage();
    photo.addAll(pickedImages);
    update();
  }
  Future imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null){
      photo.add(image);
      update();
    }
  }
  PageController pageController = PageController(viewportFraction: 0.85);
  List<Province> provinceList = [];
  List<Districts> districtsList = [];
  List<Wards> wardsList = [];
  late Address address;
  bool isPersonal = true;
  late bool isSale = false;
  bool isHandover = false;
  Province? selectedProvince;
  Districts? selectedDistricts;
  Wards? selectedWards;
   String? selectedPropertyCertificate;
  //post
  String title = "";
  String description = "";
  double area = 0;
  int price = 0;
  int? deposit;
  String projectName = "";
  int floor = 0;
  int? numberOfFloor;
  String block = "";
  String? subdivisionName;
  String? landCode;
  int? numberOfToilet;
  int? numberOfBedroom;

  double? usedArea ;
  double height = 0;
  double  width = 0;
  int? electricPrice;
  int? waterPrice;
  PropertyType? selectedPropertyType;
  bool isFacade = false;
  bool isWidensTowardsTheBack = false;
  bool hasWideAlley = false;
  bool isCorner = false;
  String interiorState = "";
  Map<Direction, String> directionMap ={
    Direction.east : 'Đông',
    Direction.west : 'Tây',
    Direction.south : 'Nam',
    Direction.north : 'Bắc',
    Direction.northEast : 'Đông Bắc',
    Direction.southEast : 'Đông Nam',
    Direction.northWest : 'Tây Bắc',
    Direction.southWest : 'Tây Nam',
  };
   Direction? directionDoor;
   Direction? balconyDirection;
   Direction? landDirection;
  Map<FurnitureStatus, String> iteriorMap = {
    FurnitureStatus.highEnd : 'Nội thất cao cấp',
    FurnitureStatus.full : 'Nội thất đầy đủ',
    FurnitureStatus.basic : 'Hoàn thiện cơ bản',
    FurnitureStatus.empty : 'Bàn giao thô',
  };
   FurnitureStatus? furnitureStatus;

  Map<PropertyType, String> propertyMap ={
    PropertyType.office : 'Văn phòng, Mặt bằng kinh doanh',
    PropertyType.land : 'Đất',
    PropertyType.house : 'Nhà ở',
    PropertyType.motel : 'Phòng trọ',
    PropertyType.apartment : 'Căn hộ/Chung cư',
  };
  Map<LegalDocumentStatus, String> certificateMap = {
    LegalDocumentStatus.haveCertificate : 'Đã có sổ',
    LegalDocumentStatus.waitingForCertificate : 'Đang chờ sổ',
    LegalDocumentStatus.otherDocuments : 'Giấy tờ khác',
  };
  LegalDocumentStatus? legalStatus;
  Map<ApartmentType, String> apartmentMap = {
    ApartmentType.dormitory : 'Chung cư',
    ApartmentType.duplex : 'Duplex',
    ApartmentType.penhouse : 'Penthouse',
    ApartmentType.service : 'Căn hộ dịch vụ, mini',
    ApartmentType.officetel : 'Officetel',

  };
  ApartmentType? apartmentType;
  Map<LandType, String> landMap = {
    LandType.residential : 'Đất thổ cư',
    LandType.project : 'Đất nền dự án',
    LandType.agricultural : 'Đất nông nghiệp',
    LandType.industrial : 'Đất công nghiệp',
  };
  LandType? landType;
  Map<HouseType, String> houseMap = {
    HouseType.townHouse : 'Nhà mặt phố',
    HouseType.frontHouse: 'Nhà mặt tiền',
    HouseType.alleyHouse: 'Nhà ngõ, hẻm',
    HouseType.villa : 'Nhà biệt thự',
    HouseType.rowHouse : 'Nhà liền kề',
  };
  HouseType? houseType;
  String addressDisplay = "";
  Map<OfficeType, String> officeMap= {
    OfficeType.commercialSpace: 'Mặt bằng kinh doanh',
    OfficeType.office: 'Văn phòng',
    OfficeType.shopHouse: 'Shophouse',
    OfficeType.officetel: 'Officetel',
  };
   OfficeType? officeType;
  final TextEditingController addressController = TextEditingController();

  void setAddress(){
    addressController.text = selectedProvince!.name.toString() + " " + selectedDistricts!.name.toString() + " " + selectedWards!.name.toString();
    address = Address(cityCode: (selectedProvince!.code!), districtCode: (selectedDistricts!.code!) , wardCode: (selectedWards!.code!) ,);
    update();
  }
  void initBody(){
    isPersonal = true;
  }
  void setVisibility(PropertyType value){
    selectedPropertyType = value;
    initBody();
    if(selectedPropertyType  != PropertyType.motel){
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
  void addPost(){
    Post post;
    DateTime now = DateTime.now();
    switch (selectedPropertyType){
      case PropertyType.office:
        post = Office(
            furnitureStatus: furnitureStatus ,
            id: now.toString(),
            area: area,
            type: PropertyType.office,
            address: address,
            userID: "1",
            isLease: !isSale,
            price: price,
            title: title,
            description: description,
            postedDate: now,
            expiryDate: now.add(const Duration(days: 14)),
            imagesUrl: [],
            isProSeller: !isPersonal,
            projectName: projectName,
            deposit: deposit,
            numOfLikes: 0);
        print(post.toString());

        break;
      case PropertyType.land:
        print("Create Land");
        post = Land(id: now.toString(),
            area: area,
            projectName: projectName,
            landLotCode:  landCode,
            subdivisionName: subdivisionName,
            landType: landType,
            width:  width,
            length: height,
            landDirection: landDirection,
            legalDocumentStatus: legalStatus,
            isFacade: isFacade,
            isWidensTowardsTheBack: isWidensTowardsTheBack,
            hasWideAlley: hasWideAlley,
            address: address,
            type: PropertyType.land,
            userID: "1",
            isLease: !isSale,
            price: price,
            title: title,
            description: description,
            postedDate: now,
            expiryDate: now.add( const Duration(days: 14)) ,
            imagesUrl: [],
            isProSeller: !isPersonal,
            deposit: deposit,
            numOfLikes: 0);
        print(post.toString());
          break;
      case PropertyType.house:
        post = House(
            id: now.toString(),
            furnitureStatus: furnitureStatus,
            area: (area),
            projectName: projectName,
            hasWideAlley: hasWideAlley, 
            isFacade: isFacade, 
            areaUsed: usedArea,
            width: width,
            length: height,
            houseType: houseType,
            numOfBedRooms: (numberOfBedroom),
            numOfToilets: (numberOfToilet),
            numOfFloors: numberOfFloor,
            mainDoorDirection: directionDoor,
            legalDocumentStatus: legalStatus,
            address: address, 
            type: PropertyType.house,
            userID: "1",
            isLease: !isSale,
            price: (price),
            title: title, 
            description: description,
            postedDate: now,
            expiryDate: now.add(Duration(days: 14)),
            imagesUrl: [],
            isProSeller: !isPersonal,
            deposit: deposit,
            numOfLikes: 0);
        print(post.toString());
        break;
      case PropertyType.apartment:
        post = Apartment(
            id: now.toString(),
            furnitureStatus: furnitureStatus,
            area: (area),
            projectName: projectName,
            apartmentType: apartmentType,
            isCorner: isCorner, 
            isHandOver: isHandover ,
            numOfBedRooms: (numberOfBedroom),
            balconyDirection: balconyDirection,
            mainDoorDirection: directionDoor,
            numOfToilets: (numberOfToilet),
            block: block.isEmpty ? null: block,
            legalDocumentStatus: legalStatus, 
            floor: (floor),
            address: address,
            type: PropertyType.apartment,
            userID: "1",
            isLease: !isSale,
            price:(price),
            title: title, 
            description: description,
            postedDate: now,
            expiryDate: now.add(Duration(days: 14)),
            imagesUrl: [],
            isProSeller: !isPersonal,
            deposit: deposit,
            numOfLikes: 0);
        print(post.toString());
        break;
      case PropertyType.motel:
        post = Motel(
            id: now.toString(),
            furnitureStatus: furnitureStatus,
            area: (area),
            projectName: projectName,
            electricPrice: electricPrice,
            waterPrice: waterPrice,
            address: address,
            type: PropertyType.motel,
            userID: "1",
            isLease: !isSale,
            price: price,
            title: title,
            description: description,
            postedDate: now,
            expiryDate: now.add(Duration(days: 14)),
            imagesUrl: [],
            isProSeller: !isPersonal,
            deposit: deposit,
            numOfLikes: 0);
        print(post.toString());
        break;
      case null: break;
    }
    print("Created Post");
  }
}
