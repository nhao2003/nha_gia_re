import 'package:get/get.dart';
import 'package:nha_gia_re/data/services/list_check_service.dart';
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
    resetAll();
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

// reset radio ==========================================
  void resetAll() {
    resetApartment();
    resetHouse();
    resetLand();
    resetOffice();
    resetRent();
  }

  void resetApartment() {
    apartmentStatus.reset();
    apartmentTypes.reset();
    apartmentCharacteristics.reset();
    apartmentBedroomNumber.reset();
    apartmentMainDirection.reset();
    apartmentBalconyDirection.reset();
    apartmentLegalDocuments.reset();
    apartmentInteriorStatus.reset();
  }

  void resetHouse() {
    houseTypes.reset();
    houseCharacteristics.reset();
    houseBedroomNumber.reset();
    houseMainDirection.reset();
    houseLegalDocuments.reset();
    houseInteriorStatus.reset();
  }

  void resetLand() {
    landTypes.reset();
    landCharacteristics.reset();
    landDirection.reset();
    landLegalDocuments.reset();
  }

  void resetOffice() {
    officeType.reset();
    officeDirection.reset();
    officeLegalDocuments.reset();
    officeInteriorStatus.reset();
  }

  void resetRent() {
    rentInteriorStatus.reset();
  }

// Can ho chung cu ======================================
  RadioService apartmentStatus = RadioService(
    values: FilterValues.instance.status,
  );
  ListCheckService apartmentTypes = ListCheckService(
    values: FilterValues.instance.apartmentTypes,
  );
  RadioService apartmentCharacteristics = RadioService(
    values: FilterValues.instance.apartmentCharacteristics,
  );
  ListCheckService apartmentBedroomNumber = ListCheckService(
    values: FilterValues.instance.bedroomNumber,
  );
  ListCheckService apartmentMainDirection = ListCheckService(
    values: FilterValues.instance.mainDirection,
  );
  ListCheckService apartmentBalconyDirection = ListCheckService(
    values: FilterValues.instance.mainDirection,
  );
  ListCheckService apartmentLegalDocuments = ListCheckService(
    values: FilterValues.instance.legalDocuments,
  );
  RadioService apartmentInteriorStatus = RadioService(
    values: FilterValues.instance.interiorStatus,
  );
// Nha o ================================================
  ListCheckService houseTypes = ListCheckService(
    values: FilterValues.instance.residentialTypes,
  );
  ListCheckService houseCharacteristics = ListCheckService(
    values: FilterValues.instance.houseCharacteristics,
  );
  ListCheckService houseBedroomNumber = ListCheckService(
    values: FilterValues.instance.bedroomNumber,
  );
  ListCheckService houseMainDirection = ListCheckService(
    values: FilterValues.instance.mainDirection,
  );
  ListCheckService houseLegalDocuments = ListCheckService(
    values: FilterValues.instance.legalDocuments,
  );
  RadioService houseInteriorStatus = RadioService(
    values: FilterValues.instance.interiorStatus,
  );
// Dat ================================================
  ListCheckService landTypes = ListCheckService(
    values: FilterValues.instance.typeOfLand,
  );
  ListCheckService landCharacteristics = ListCheckService(
    values: FilterValues.instance.houseCharacteristics,
  );
  ListCheckService landDirection = ListCheckService(
    values: FilterValues.instance.mainDirection,
  );
  ListCheckService landLegalDocuments = ListCheckService(
    values: FilterValues.instance.legalDocuments,
  );
// Van phong  ================================================
  ListCheckService officeType = ListCheckService(
    values: FilterValues.instance.officeType,
  );
  ListCheckService officeDirection = ListCheckService(
    values: FilterValues.instance.mainDirection,
  );
  ListCheckService officeLegalDocuments = ListCheckService(
    values: FilterValues.instance.legalDocuments,
  );
  RadioService officeInteriorStatus = RadioService(
    values: FilterValues.instance.interiorStatus,
  );
// Phong tro  ================================================
  RadioService rentInteriorStatus = RadioService(
    values: FilterValues.instance.interiorStatus,
  );
}
