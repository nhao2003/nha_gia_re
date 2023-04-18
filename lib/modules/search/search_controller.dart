import 'package:get/get.dart';
import 'package:nha_gia_re/modules/search/screens/filter_screen.dart';

class SearchController extends GetxController {
  /// instance
  static SearchController get i => Get.find();

// data in search screen
  /// list dummy data
  final List<String> dummydata = ["nha 3 tang", "nha lau", "nha tro"];

  /// data in search delegate
  final List<String> history = <String>['apple', 'hello', 'world', 'flutter'];

  /// list suggestions in search
  RxList<String> suggestions = <String>[].obs;

  /// Name of screen
  String sreenName = 'Tìm kiếm';

  /// hint text int textField
  final String hintText = "Mua bán văn phòng";

// data in result screen

  /// value in dropdown menu item
  RxString selectedTypeItem = provinces[0].obs;

  /// change new value to selectedTypeItem
  void changeSelectedItem(String newValue) {
    selectedTypeItem.value = newValue;
  }

  /// add new query to history
  void addToHistory(String newQuery) {
    if (newQuery == "") return; // should not be null
    // check in history has newQuery, if had => delete and add in the top
    if (checkIsInHistory(newQuery)) deleteHistory(newQuery);
    // add to history
    history.insert(0, newQuery);
  }

  /// check is in history has newQuery
  bool checkIsInHistory(String query) {
    for (String q in history) {
      if (q == query) return true;
    }
    return false;
  }

  /// delete a query in history
  void deleteHistory(String query) {
    history.remove(query);
    // update suggestion to sync
    updateSuggestions("");
  }

  /// get list Suggestions
  List<String> getSuggestions(String query) {
    return query.isEmpty
        ? [...history]
        : dummydata.where((word) => word.startsWith(query)).toList();
  }

  /// update suggestions
  void updateSuggestions(String query) async {
    suggestions.value = getSuggestions(query);
  }

  /// navigator to filter screen
  void navigateToFilterScreen() {
    Get.to(FilterScreen());
  }

  void popScreen() {
    Get.back();
  }

  void deleteFilter() {
    //
    print("Delete filter");
  }
// Category type ==================================

  List<String> categorys = [
    "Tất cả bất động sản",
    "Căn Hộ chung Cư",
    "Nhà ở",
    "Đất",
    "Văn Phòng",
  ];

  RxInt selectedCategory = 0.obs;

  void changeCategory(int? type) {
    selectedCategory.value = type!;
    Get.back();
  }

// sort card ======================================
  List<String> sortTypes = [
    "Tin mới trước",
    "Giá thấp trước",
  ];

  RxInt selectedSortType = 0.obs;

  void changeSortType(int? type) {
    selectedSortType.value = type!;
  }

// posted card ======================================
  List<String> postedBys = [
    "Cá nhân",
    "Môi giới",
  ];

  RxInt selectedpostedBy = 0.obs;

  void changePostedBy(int? type) {
    selectedpostedBy.value = type!;
  }

// Slider ranges ==================================
  // Price range
  static const double LOWER_PRICE = 0;
  static const double UPPER_PRICE = 30000000000;
  RxDouble lowerPriceValue = 0.0.obs;
  RxDouble upperPriceValue = 30000000000.0.obs;

  void changeValuePrice(double lower, double upper) {
    lowerPriceValue.value = lower;
    upperPriceValue.value = upper;
  }

  // Area range
  static const double LOWER_AREA = 0;
  static const double UPPER_AREA = 10000;
  RxDouble lowerAreaValue = 0.0.obs;
  RxDouble upperAreaValue = 10000.0.obs;

  void changeAreaPrice(double lower, double upper) {
    lowerAreaValue.value = lower;
    upperAreaValue.value = upper;
  }

  static List<String> provinces = [
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
