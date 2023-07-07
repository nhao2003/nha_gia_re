import 'package:nha_gia_re/data/enums/enums.dart';

class FilterValues {
  // sigleton
  static final FilterValues instance = FilterValues._internal();

  factory FilterValues() {
    return instance;
  }

  FilterValues._internal();

  // card first value
  List<String> categorys = [
    "Tất cả bất động sản",
    "Căn Hộ/chung Cư",
    "Nhà ở",
    "Đất",
    "Văn Phòng, Mặt bằng kinh doanh",
    "Phòng trọ",
  ];

// sort card
  List<String> sortTypes = [
    "Tin mới trước",
    "Giá thấp trước",
  ];
// posted card
  List<String> postedBy = [
    "Cá nhân",
    "Môi giới",
  ];
// Price range
  double LOWER_PRICE = 0;
  double UPPER_PRICE = 300000000000;
// Area range
  double LOWER_AREA = 0;
  double UPPER_AREA = 10000;

// Specifications (Thông số kĩ thuật)
  // Can ho, chung cu
  List<String> status = [
    "Tất cả",
    "Chưa bàn giao",
    "Đã bàn giao",
  ];

  List<String> apartmentTypes =
      ApartmentType.values.map((e) => e.toString()).toList();

  List<String> apartmentCharacteristics = [
    "Tất cả",
    "Căn góc",
  ];
  List<String> bedroomNumber = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "Nhiều hơn 10",
  ];
  List<String> mainDirection =
      Direction.values.map((e) => e.toString()).toList();
  List<String> legalDocuments =
      LegalDocumentStatus.values.map((e) => e.toString()).toList();
  List<String> interiorStatus =
      FurnitureStatus.values.map((e) => e.toString()).toList();
  // Nha o
  List<String> residentialTypes =
      HouseType.values.map((e) => e.toString()).toList();

  List<String> houseCharacteristics = [
    "Hẽm xe hơi",
    "Mặt tiền",
    "Nở hậu",
  ];
  // Đất
  List<String> typeOfLand = LandType.values.map((e) => e.toString()).toList();
  // van phong
  List<String> officeType = OfficeType.values.map((e) => e.toString()).toList();
// provinces of VietNam
  List<String> provinces = [
    'Toàn Quốc',
    'Hà Nội',
    'Hà Giang',
    'Cao Bằng',
    'Bắc Kạn',
    'Tuyên Quang',
    'Lào Cai',
    'Điện Biên',
    'Lai Châu',
    'Sơn La',
    'Yên Bái',
    'Hòa Bình',
    'Thái Nguyên',
    'Lạng Sơn',
    'Quảng Ninh',
    'Bắc Giang',
    'Phú Thọ',
    'Vĩnh Phúc',
    'Bắc Ninh',
    'Hải Dương',
    'Hải Phòng',
    'Hưng Yên',
    'Thái Bình',
    'Hà Nam',
    'Nam Định',
    'Ninh Bình',
    'Thanh Hóa',
    'Nghệ An',
    'Hà Tĩnh',
    'Quảng Bình',
    'Quảng Trị',
    'Thừa Thiên Huế',
    'Đà Nẵng',
    'Quảng Nam',
    'Quảng Ngãi',
    'Bình Định',
    'Phú Yên',
    'Khánh Hòa',
    'Ninh Thuận',
    'Bình Thuận',
    'Kon Tum',
    'Gia Lai',
    'Đắk Lắk',
    'Đắk Nông',
    'Lâm Đồng',
    'Bình Phước',
    'Tây Ninh',
    'Bình Dương',
    'Đồng Nai',
    'Bà Rịa - Vũng Tàu',
    'Hồ Chí Minh',
    'Long An',
    'Tiền Giang',
    'Bến Tre',
    'Trà Vinh',
    'Vĩnh Long',
    'Đồng Tháp',
    'An Giang',
    'Kiên Giang',
    'Cần Thơ',
    'Hậu Giang',
    'Sóc Trăng',
    'Bạc Liêu',
    'Cà Mau'
  ];
}
