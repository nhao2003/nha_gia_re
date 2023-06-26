import '../../../enums/enums.dart';

class PostFilter {
  String? textSearch;
  OrderBy orderBy;
  String? postedByUserID;
  bool? isLease;
  int? from;
  int? to;
  int? minPrice;
  int? maxPrice;
  int? minArea;
  int? maxArea;
  PostedBy postedBy;

  PostFilter({
    this.textSearch,
    this.isLease,
    this.postedByUserID,
    required this.orderBy,
    this.from,
    this.to,
    this.minPrice,
    this.maxPrice,
    this.minArea,
    this.maxArea,
    required this.postedBy,
  }) : assert((from != null && to != null && from < to) ||
            (from == null && to == null));
  
  void setTextSearch(String text) {
    textSearch = text;
  }

  void setOrderBy(OrderBy orderBy) {
    this.orderBy = orderBy;
  }

  void setIsLease(bool isLease) {
    this.isLease = isLease;
  }

  void setPostedBy(PostedBy postedBy) {
    this.postedBy = postedBy;
  }
}

class ApartmentFilter extends PostFilter {
  bool? isHandedOver;
  List<ApartmentType> apartmentTypes;
  bool? isCorner;
  List<int> numOfBedrooms;
  List<Direction> mainDoorDirections;
  List<Direction> balconyDirections;
  List<LegalDocumentStatus> legalStatus;
  List<FurnitureStatus> furnitureStatus;

  ApartmentFilter({
    String? textSearch,
    String? postedByUserID,
    bool? isLease,
    required OrderBy orderBy,
    required int from,
    required int to,
    required int minPrice,
    required int maxPrice,
    required int minArea,
    required int maxArea,
    required PostedBy postedBy,
    this.isHandedOver,
    this.apartmentTypes = const [],
    this.isCorner,
    this.numOfBedrooms = const [],
    this.mainDoorDirections = const [],
    this.balconyDirections = const [],
    this.legalStatus = const [],
    this.furnitureStatus = const [],
  }) : super(
          postedByUserID: postedByUserID,
          textSearch: textSearch,
          orderBy: orderBy,
          from: from,
          to: to,
          minPrice: minPrice,
          maxPrice: maxPrice,
          minArea: minArea,
          maxArea: maxArea,
          postedBy: postedBy,
        );
}

class HouseFilter extends PostFilter {
  bool? hasWideAlley;
  bool? isFacade;
  bool? isWidensTowardsTheBack;
  List<HouseType> houseTypes;
  List<int> numOfBedrooms;
  List<Direction> mainDoorDirections;
  List<LegalDocumentStatus> legalStatus;
  List<FurnitureStatus> furnitureStatus;

  HouseFilter({
    String? postedByUserID,
    String? textSearch,
    bool? isLease,
    required OrderBy orderBy,
    required int from,
    required int to,
    required int minPrice,
    required int maxPrice,
    required int minArea,
    required int maxArea,
    required PostedBy postedBy,
    this.hasWideAlley,
    this.isFacade,
    this.isWidensTowardsTheBack,
    this.houseTypes = const [],
    this.numOfBedrooms = const [],
    this.mainDoorDirections = const [],
    this.legalStatus = const [],
    this.furnitureStatus = const [],
  }) : super(
          postedByUserID: postedByUserID,
          textSearch: textSearch,
          orderBy: orderBy,
          from: from,
          to: to,
          minPrice: minPrice,
          maxPrice: maxPrice,
          minArea: minArea,
          maxArea: maxArea,
          postedBy: postedBy,
        );
}

class LandFilter extends PostFilter {
  bool? hasWideAlley;
  bool? isFacade;
  bool? isWidensTowardsTheBack;
  List<LandType> landTypes;
  List<Direction> landDirections;
  List<LegalDocumentStatus> legalStatus;

  LandFilter({
    String? textSearch,
    String? postedByUserID,
    bool? isLease,
    required OrderBy orderBy,
    required int from,
    required int to,
    required int minPrice,
    required int maxPrice,
    required int minArea,
    required int maxArea,
    required PostedBy postedBy,
    this.hasWideAlley,
    this.isFacade,
    this.isWidensTowardsTheBack,
    this.landTypes = const [],
    this.landDirections = const [],
    this.legalStatus = const [],
  }) : super(
          postedByUserID: postedByUserID,
          textSearch: textSearch,
          orderBy: orderBy,
          from: from,
          to: to,
          minPrice: minPrice,
          maxPrice: maxPrice,
          minArea: minArea,
          maxArea: maxArea,
          postedBy: postedBy,
        );
}

class OfficeFilter extends PostFilter {
  List<OfficeType> officeTypes;
  List<Direction> mainDoorDirections;
  List<LegalDocumentStatus> legalStatus;
  List<FurnitureStatus> furnitureStatus;

  OfficeFilter({
    String? postedByUserID,
    String? textSearch,
    bool? isLease,
    required OrderBy orderBy,
    required int from,
    required int to,
    required int minPrice,
    required int maxPrice,
    required int minArea,
    required int maxArea,
    required PostedBy postedBy,
    this.officeTypes = const [],
    this.mainDoorDirections = const [],
    this.legalStatus = const [],
    this.furnitureStatus = const [],
  }) : super(
          textSearch: textSearch,
          postedByUserID: postedByUserID,
          orderBy: orderBy,
          from: from,
          to: to,
          minPrice: minPrice,
          maxPrice: maxPrice,
          minArea: minArea,
          maxArea: maxArea,
          postedBy: postedBy,
        );
}

class MotelFilter extends PostFilter {
  List<FurnitureStatus> furnitureStatus;

  MotelFilter({
    String? textSearch,
    String? postedByUserID,
    bool? isLease,
    required OrderBy orderBy,
    required int from,
    required int to,
    required int minPrice,
    required int maxPrice,
    required int minArea,
    required int maxArea,
    required PostedBy postedBy,
    this.furnitureStatus = const [],
  }) : super(
          postedByUserID: postedByUserID,
          textSearch: textSearch,
          orderBy: orderBy,
          from: from,
          to: to,
          minPrice: minPrice,
          maxPrice: maxPrice,
          minArea: minArea,
          maxArea: maxArea,
          postedBy: postedBy,
        );
}
