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
  double UPPER_PRICE = 30000000000;
// Area range
  double LOWER_AREA = 0;
  double UPPER_AREA = 10000;

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
