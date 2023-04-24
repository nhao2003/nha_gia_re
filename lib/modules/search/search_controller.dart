import 'package:get/get.dart';
import 'package:nha_gia_re/data/services/radio_service.dart';
import 'package:nha_gia_re/modules/search/screens/filter_screen.dart';

import '../../core/values/filter_values.dart';

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
  RxString selectedTypeItem = FilterValues.instance.provinces[0].obs;

  /// change new value to selectedTypeItem
  void changeSelectedItem(String newValue) {
    selectedTypeItem.value = newValue;
  }

  /// add new query to history
  void addToHistory(String newQuery) {
    if (newQuery.trim() == "") return; // should not be null
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
    Get.to(() => FilterScreen());
  }

  void popScreen() {
    Get.back();
  }

  void deleteFilter() {
    // reset all
    radioCategory.selectedValue.value = 0;
    radioSortType.selectedValue.value = 0;
    radiopostedBy.selectedValue.value = 0;
    changeValuePrice(
        FilterValues.instance.LOWER_PRICE, FilterValues.instance.UPPER_PRICE);
    changeAreaValue(
        FilterValues.instance.LOWER_AREA, FilterValues.instance.UPPER_AREA);
  }

// Category type ==================================
  RadioService radioCategory = RadioService(
    values: FilterValues.instance.categorys,
    expendedFunc: () => Get.back(),
  );

// sort card ======================================
  RadioService radioSortType = RadioService(
    values: FilterValues.instance.sortTypes,
  );

// posted card ======================================
  RadioService radiopostedBy = RadioService(
    values: FilterValues.instance.postedBy,
  );
// Slider ranges ==================================
  // Price range

  RxDouble lowerPriceValue = FilterValues.instance.LOWER_PRICE.obs;
  RxDouble upperPriceValue = FilterValues.instance.UPPER_PRICE.obs;

  void changeValuePrice(double lower, double upper) {
    lowerPriceValue.value = lower;
    upperPriceValue.value = upper;
  }

  // Area range

  RxDouble lowerAreaValue = FilterValues.instance.LOWER_AREA.obs;
  RxDouble upperAreaValue = FilterValues.instance.UPPER_AREA.obs;

  void changeAreaValue(double lower, double upper) {
    lowerAreaValue.value = lower;
    upperAreaValue.value = upper;
  }
}
