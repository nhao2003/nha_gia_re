import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/models/province.dart';
import 'package:nha_gia_re/data/providers/remote/request/post_request.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/data/services/upload_avatar_service.dart';
import '../../data/enums/enums.dart';
import '../../data/models/properties/post.dart';

class PropertyController extends GetxController{
  PropertyController();
  void editPost(Post post){

  }
  final authRepository = GetIt.instance<AuthRepository>();
  final postRepository = GetIt.instance<PostRepository>();
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

  void setProvince(Province? value){
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
  void deleteImage(int index){
    photo.removeAt(index);
    checkLengthPhoto();
    update();
  }
  bool? photoController;
  void checkLengthPhoto(){
    int length = photo.length;
    if(length >= 3 && length <= 10){
      photoController = true;
    }
    else {
      photoController = false;
    }
    update();
  }
  List<File> photo  = [];
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async{
    final pickedImages = await _picker.pickMultiImage();
    for(int i = 0; i < pickedImages.length; i++){
      photo.add(File(pickedImages[i].path));
    }
    checkLengthPhoto();
    update();
  }

  Future imgFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null){
      photo.add(File(image.path));
      checkLengthPhoto();
      update();
    }
  }
  List<String> imageUrls = [
    'https://cdn.chotot.com/anAdm6N2zHhMfbXZZsubfp-7mwhmYUpLZW8SceXS5IY/preset:view/plain/da0d49f0a1c267c8ce15a7074e18f2c2-2824246476756169141.jpg',
    "https://cdn.chotot.com/YcT9_B1NOr1-jjveVZoLB2cuFTyOYIUvRLW1dqMVV5o/preset:view/plain/b7cb37b6facd4163bc976f37b8cdf1e8-2811332062328596281.jpg",
    "https://cdn.chotot.com/CfGsMoWBJT1DyHpnZ8-HewH4yU-fqpXGe-DMTFVI0EE/preset:view/plain/4d0ed210a1790ea9a6b1695d78643010-2824246234360911779.jpg"
  ];
  PageController pageController = PageController(viewportFraction: 0.85);
  List<Province?> provinceList = [];
  List<District?> districtsList = [District()];
  List<Ward?> wardsList = [Ward()];
  late Address address;
  bool isPersonal = true;
  late bool isSale = false;
  bool isHandover = false;
  Province? selectedProvince;
  District? selectedDistrict;
  Ward? selectedWard;
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
  int modelDeposit = 0;
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
   OfficeType? officeType = OfficeType.officetel;
  final TextEditingController addressController = TextEditingController();

  void setAddress(){
   // addressController.text = provinceList[selectedProvince!]!.name.toString() + " " + districtsList[selectedDistrict!]!.name.toString() + " " + wardsList[selectedWard!].name.toString();
    //address = Address(cityCode: (selectedProvince!.code != null ? selectedProvince!.code! : 0), districtCode: (selectedDistrict!.code != null ? selectedDistrict!.code! : 0) , wardCode: (selectedWard!.code!) ,);
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

  Future<void> addPost() async {
    if(authRepository.userID == null) return;
    final imageUrls =  await uploadPostImages(photo);
    print("user ton tai" + imageUrls.length.toString() + "  " + photo.length.toString() );
    PostRequest post;
    DateTime now = DateTime.now();
    switch (selectedPropertyType){
      case PropertyType.office:
        post = OfficeRequest(
            furnitureStatus: furnitureStatus ,
            area: area,
            address: address,
            userID: authRepository.userID!,
            isLease: !isSale,
            price: price,
            title: title,
            description: description,
            imagesUrl: imageUrls,
            isProSeller: !isPersonal,
            projectName: projectName,
            deposit: deposit,
            hasWideAlley: hasWideAlley,
            isFacade: isFacade,
            officeType: officeType,
            mainDoorDirection: directionDoor,
            legalDocumentStatus: legalStatus,
            );
        print(post.toString());
        await postRepository.createPost(post);

        break;
      case PropertyType.land:
        print("Create Land");
        print(landCode);
        post = LandRequest(
            area: area,
            projectName: projectName,
            landLotCode:  landCode?.trim() == ""? null: landCode,
            subdivisionName: subdivisionName?.trim() == ""? null: subdivisionName,
            landType: landType,
            width:  width,
            length: height,
            landDirection: landDirection,
            legalDocumentStatus: legalStatus,
            isFacade: isFacade,
            isWidensTowardsTheBack: isWidensTowardsTheBack,
            hasWideAlley: hasWideAlley,
            address: address,
            userID: authRepository.userID!,
            isLease: !isSale,
            price: price,
            title: title,
            description: description,
            imagesUrl: imageUrls,
            isProSeller: !isPersonal,
            deposit: deposit,
        );
        print(post.toString());
        await postRepository.createPost(post);

        break;
      case PropertyType.house:
        post = HouseRequest(
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
            userID: authRepository.userID!,
            isLease: !isSale,
            price: (price),
            title: title, 
            description: description,
            imagesUrl: imageUrls,
            isProSeller: !isPersonal,
            deposit: deposit,
            isWidensTowardsTheBack: isWidensTowardsTheBack);
        print(post.toString());
        await postRepository.createPost(post);

        break;
      case PropertyType.apartment:
        post = ApartmentRequest(
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
            userID: authRepository.userID!,
            isLease: !isSale,
            price:(price),
            title: title, 
            description: description,
            imagesUrl: imageUrls,
            isProSeller: !isPersonal,
            deposit: deposit,
            );
        await postRepository.createPost(post);

        print(post.toString());
        break;
      case PropertyType.motel:
        post = MotelRequest(
            furnitureStatus: furnitureStatus,
            area: (area),
            projectName: projectName,
            electricPrice: electricPrice,
            waterPrice: waterPrice,
            address: address,
            userID: authRepository.userID!,
            price: price,
            title: title,
            description: description,
            imagesUrl: imageUrls,
            isProSeller: !isPersonal,
            deposit: modelDeposit,
            );
        await postRepository.createPost(post);

        break;
      case null: break;
    }
    print("Created Post");
  }
}
