import '../../../enums/enums.dart';

class PostFilter {
  String? textSearch;
  OrderBy orderBy;
  int from;
  int to;
  int minPrice;
  int maxPrice;
  int minArea;
  int maxArea;
  PostedBy postedBy;

  PostFilter({
    this.textSearch,
    required this.orderBy,
    required this.from,
    required this.to,
    required this.minPrice,
    required this.maxPrice,
    required this.minArea,
    required this.maxArea,
    required this.postedBy,
  });
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
    String? textSearch,
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
    String? textSearch,
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
