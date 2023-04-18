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
