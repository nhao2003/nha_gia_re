import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/string_ex.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:nha_gia_re/data/services/list_check_service.dart';
import 'package:nha_gia_re/data/services/radio_service.dart';
import 'package:nha_gia_re/modules/search/screens/filter_screen.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import '../../core/values/filter_values.dart';
import '../../data/enums/enums.dart';
import '../../data/models/properties/post.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/post_repository.dart';

class SearchController extends GetxController {
  /// instance
  static SearchController get i => Get.find();
// type of result
  // type of navigate when navigate from home
  TypeNavigate typeResult = TypeNavigate.search;
  String province = ""; // province when navigate

  void setTypeResult(TypeNavigate type) {
    typeResult = type;
    province = "";
    if (type == TypeNavigate.province) {
      province = Get.arguments["province"];
      selectedTypeItem.value = Get.arguments["province"];
    }
  }

// voice controller
  RxBool isListening = false.obs;

  void toggleListening(bool check) {
    isListening.value = check;
  }

// data in search screen
  /// query of search bar
  String _query = "";

  void changeQuery(String newQuery) {
    _query = newQuery;
  }

  /// list dummy data
  final List<String> dummydata = [
    "nha 3 tang",
    "nha lau",
    "nha tro",
    "Dat nong nghiep",
  ];

  final RxList<String> searchStrings = <String>[].obs;

  Future<RxList<String>> getSearchString() async {
    List<Post> datas = await repository.getUserPosts(AuthRepository().userID!);
    searchStrings.clear();
    for (var data in datas) {
      searchStrings.add(data.title);
      print(data.title);
    }
    return searchStrings;
  }

  RxList<Post> searchPosts = <Post>[].obs;

  Future<void> initPosts(OrderBy orderby) async {
    // init search post for tab
    // có 2 tab: order by giá và thời gian
    // có 4 loại: search, sell, rent, province
    // khai báo 1 init filter
    PostFilter filter = PostFilter(
      orderBy: orderby,
      postedBy: PostedBy.all,
    );
    if (typeResult == TypeNavigate.search) {
      filter = PostFilter(
        textSearch: _query,
        orderBy: orderby,
        postedBy: PostedBy.all,
      );
    } else if (typeResult == TypeNavigate.sell) {
      // for sell
      filter = PostFilter(
        orderBy: orderby,
        isLease: false,
        postedBy: PostedBy.all,
      );
    } else if (typeResult == TypeNavigate.rent) {
      // for rent
      filter = PostFilter(
        orderBy: orderby,
        isLease: true,
        postedBy: PostedBy.all,
      );
    } else if (typeResult == TypeNavigate.province) {
      // for province
      changeSelectedItem(province);
      return;
    }

    searchPosts.value = await repository.getAllPosts(filter);
  }

  /// data in search delegate
  final List<String> history = <String>[
    'nha tro',
    'ban nha',
    'chung cu',
    'van phong',
  ];

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
  void changeSelectedItem(String newValue) async {
    selectedTypeItem.value = newValue;
    // add filter
    if (newValue == FilterValues.instance.provinces[0]) {
      initPosts(OrderBy.priceAsc);
    } else {
      searchPosts.value = await getPostByProvince(newValue, typeResult);
    }
  }

  Future<List<Post>> getPostByProvince(String value, TypeNavigate type) async {
    // lay tat ca cac post tren remote roi loc ra
    List<Post> filterPosts = <Post>[];
    List<Post> allPosts;
    if (type == TypeNavigate.search) {
      allPosts = await getAllPostsInitWithQuery();
    } else {
      allPosts = await getAllPostsInit();
    }
    for (var post in allPosts) {
      if (post.address.cityName!
          .noAccentVietnamese()
          .contains(value.noAccentVietnamese())) {
        filterPosts.add(post);
      }
    }
    return [...filterPosts];
  }

  Future<List<Post>> getAllPostsInit() async {
    // lay tat ca cac post tren remote
    PostFilter filter = PostFilter(
      orderBy: OrderBy.createdAtAsc,
      postedBy: PostedBy.all,
    );
    return await repository.getAllPosts(filter);
  }

  Future<List<Post>> getAllPostsInitWithQuery() async {
    // lay tat ca cac post tren remote
    PostFilter filter = PostFilter(
      textSearch: _query,
      orderBy: OrderBy.createdAtAsc,
      postedBy: PostedBy.all,
    );
    return await repository.getAllPosts(filter);
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
    // xu ly in hoa, in thuong, co dau, khong dau
    List<String> results = [];
    if (query.isEmpty) {
      results = [...history];
    } else {
      for (String value in searchStrings) {
        if (value
            .noAccentVietnamese()
            .toLowerCase()
            .startsWith(query.noAccentVietnamese().toLowerCase())) {
          results.add(value);
        }
      }
    }
    return results;
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

  void navigateToDetailSceen(Post post) {
    Get.toNamed(AppRoutes.post_detail, arguments: post);
  }

  void deleteFilter() {
    // reset all
    radioCategory.reset();
    radioSortType.reset();
    radiopostedBy.reset();

    resetAllCardsOfCategory();
    changeValuePrice(
        FilterValues.instance.LOWER_PRICE, FilterValues.instance.UPPER_PRICE);
    changeAreaValue(
        FilterValues.instance.LOWER_AREA, FilterValues.instance.UPPER_AREA);
  }

  // filter function ===============================
  /// this function use to filter post in search
  PostRepository repository = PostRepository();
  int indexStartPost = 0;
  int rangeGetPosts = 10;

  Future<void> applyFilter() async {
    final List<Post> datas;
    if (radioCategory.isEqualValue(0)) {
      // Tất cả bất động sản
      datas = await repository.getAllPosts(getPostFilter());
    } else if (radioCategory.isEqualValue(1)) {
      // Căn Hộ/chung Cư
      datas = await repository.getAllApartments(getApartmentFilter());
    } else if (radioCategory.isEqualValue(2)) {
      // Nhà ở
      datas = await repository.getAllHouses(getHouseFilter());
    } else if (radioCategory.isEqualValue(3)) {
      // Đất
      datas = await repository.getAllLands(getLandFilter());
    } else if (radioCategory.isEqualValue(4)) {
      // Văn Phòng, Mặt bằng kinh doanh
      datas = await repository.getAllOffices(getOfficeFilter());
    } else {
      // Phòng trọ
      datas = await repository.getAllMotels(getMotelFilter());
    }
    searchPosts.value = datas;
    // pop screen when done
    popScreen();
  }

  OrderBy getOrderBy() {
    if (radioSortType.isEqualValue(0)) {
      // Tin mới trước
      return OrderBy.createdAtAsc;
    } else {
      // Giá thấp trước
      return OrderBy.priceAsc;
    }
  }

  PostedBy getPostBy() {
    if (radiopostedBy.isEqualValue(0)) {
      // ca nhan
      return PostedBy.individual;
    } else {
      // moi gioi
      return PostedBy.proSeller;
    }
  }

  // get post filter
  // all
  PostFilter getPostFilter() {
    return PostFilter(
      textSearch: _query,
      orderBy: getOrderBy(),
      from: indexStartPost,
      to: indexStartPost + rangeGetPosts,
      minPrice: lowerPriceValue.value.toInt(),
      maxPrice: upperPriceValue.value.toInt(),
      minArea: lowerAreaValue.value.toInt(),
      maxArea: upperAreaValue.value.toInt(),
      postedBy: getPostBy(),
    );
  }

  // ApartmentFilter
  ApartmentFilter getApartmentFilter() {
    return ApartmentFilter(
        textSearch: _query,
        orderBy: getOrderBy(),
        from: indexStartPost,
        to: indexStartPost + rangeGetPosts,
        minPrice: lowerPriceValue.value.toInt(),
        maxPrice: upperPriceValue.value.toInt(),
        minArea: lowerAreaValue.value.toInt(),
        maxArea: upperAreaValue.value.toInt(),
        postedBy: getPostBy(),
        isHandedOver: apartmentStatus.isEqualValue(0)
            ? null
            : apartmentStatus.isEqualValue(1)
                ? false
                : true,
        apartmentTypes: apartmentTypes
            .getListSelected()
            .map((e) => ApartmentType.parse(e))
            .toList(),
        isCorner: apartmentCharacteristics.isEqualValue(0) ? null : true,
        numOfBedrooms: apartmentBedroomNumber.getListSelected().map(
          (e) {
            if (e == "Nhiều hơn 10") {
              return 11;
            } else {
              return int.parse(e);
            }
          },
        ).toList(),
        mainDoorDirections: apartmentMainDirection
            .getListSelected()
            .map((e) => Direction.parse(e))
            .toList(),
        balconyDirections: apartmentBalconyDirection
            .getListSelected()
            .map((e) => Direction.parse(e))
            .toList(),
        legalStatus: apartmentLegalDocuments
            .getListSelected()
            .map((e) => LegalDocumentStatus.parse(e))
            .toList(),
        furnitureStatus: apartmentInteriorStatus
            .getListSelected()
            .map((e) => FurnitureStatus.parse(e))
            .toList());
  }

  // HouseFilter
  HouseFilter getHouseFilter() {
    return HouseFilter(
        textSearch: _query,
        orderBy: getOrderBy(),
        from: indexStartPost,
        to: indexStartPost + rangeGetPosts,
        minPrice: lowerPriceValue.value.toInt(),
        maxPrice: upperPriceValue.value.toInt(),
        minArea: lowerAreaValue.value.toInt(),
        maxArea: upperAreaValue.value.toInt(),
        postedBy: getPostBy(),
        houseTypes: houseTypes
            .getListSelected()
            .map((e) => HouseType.parse(e))
            .toList(),
        hasWideAlley: houseCharacteristics.isEqualValue(0),
        isFacade: houseCharacteristics.isEqualValue(1),
        isWidensTowardsTheBack: houseCharacteristics.isEqualValue(2),
        numOfBedrooms: houseBedroomNumber.getListSelected().map(
          (e) {
            if (e == "Nhiều hơn 10") {
              return 11;
            } else {
              return int.parse(e);
            }
          },
        ).toList(),
        mainDoorDirections: houseMainDirection
            .getListSelected()
            .map((e) => Direction.parse(e))
            .toList(),
        legalStatus: houseLegalDocuments
            .getListSelected()
            .map((e) => LegalDocumentStatus.parse(e))
            .toList(),
        furnitureStatus: houseInteriorStatus
            .getListSelected()
            .map((e) => FurnitureStatus.parse(e))
            .toList());
  }

  // LandFilter
  LandFilter getLandFilter() {
    return LandFilter(
      textSearch: _query,
      orderBy: getOrderBy(),
      from: indexStartPost,
      to: indexStartPost + rangeGetPosts,
      minPrice: lowerPriceValue.value.toInt(),
      maxPrice: upperPriceValue.value.toInt(),
      minArea: lowerAreaValue.value.toInt(),
      maxArea: upperAreaValue.value.toInt(),
      postedBy: getPostBy(),
      landTypes:
          landTypes.getListSelected().map((e) => LandType.parse(e)).toList(),
      hasWideAlley: landCharacteristics.isEqualValue(0),
      isFacade: landCharacteristics.isEqualValue(1),
      isWidensTowardsTheBack: landCharacteristics.isEqualValue(2),
      landDirections: landDirection
          .getListSelected()
          .map((e) => Direction.parse(e))
          .toList(),
      legalStatus: landLegalDocuments
          .getListSelected()
          .map((e) => LegalDocumentStatus.parse(e))
          .toList(),
    );
  }

  // OfficeFilter
  OfficeFilter getOfficeFilter() {
    return OfficeFilter(
      textSearch: _query,
      orderBy: getOrderBy(),
      from: indexStartPost,
      to: indexStartPost + rangeGetPosts,
      minPrice: lowerPriceValue.value.toInt(),
      maxPrice: upperPriceValue.value.toInt(),
      minArea: lowerAreaValue.value.toInt(),
      maxArea: upperAreaValue.value.toInt(),
      postedBy: getPostBy(),
      officeTypes:
          officeType.getListSelected().map((e) => OfficeType.parse(e)).toList(),
      mainDoorDirections: officeDirection
          .getListSelected()
          .map((e) => Direction.parse(e))
          .toList(),
      legalStatus: landLegalDocuments
          .getListSelected()
          .map((e) => LegalDocumentStatus.parse(e))
          .toList(),
      furnitureStatus: officeInteriorStatus
          .getListSelected()
          .map((e) => FurnitureStatus.parse(e))
          .toList(),
    );
  }

  // MotelFilter
  MotelFilter getMotelFilter() {
    return MotelFilter(
      textSearch: _query,
      orderBy: getOrderBy(),
      from: indexStartPost,
      to: indexStartPost + rangeGetPosts,
      minPrice: lowerPriceValue.value.toInt(),
      maxPrice: upperPriceValue.value.toInt(),
      minArea: lowerAreaValue.value.toInt(),
      maxArea: upperAreaValue.value.toInt(),
      postedBy: getPostBy(),
      furnitureStatus: rentInteriorStatus
          .getListSelected()
          .map((e) => FurnitureStatus.parse(e))
          .toList(),
    );
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
  void resetAllCardsOfCategory() {
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
  ListCheckService apartmentInteriorStatus = ListCheckService(
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
  ListCheckService houseInteriorStatus = ListCheckService(
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
  ListCheckService officeInteriorStatus = ListCheckService(
    values: FilterValues.instance.interiorStatus,
  );
// Phong tro  ================================================
  ListCheckService rentInteriorStatus = ListCheckService(
    values: FilterValues.instance.interiorStatus,
  );
}
