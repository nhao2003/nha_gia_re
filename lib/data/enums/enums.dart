import 'package:nha_gia_re/core/values/app_strings.dart';

enum PropertyType {
  apartment,
  land,
  office,
  motel,
  house;

  static PropertyType parse(String value) {
    for (PropertyType type in PropertyType.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse PropertyType! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case PropertyType.apartment:
        return AppStrings.propertyTypeApartment;
      case PropertyType.land:
        return AppStrings.propertyTypeLand;
      case PropertyType.office:
        return AppStrings.propertyTypeOffice;
      case PropertyType.motel:
        return AppStrings.propertyTypeMotel;
      case PropertyType.house:
        return AppStrings.propertyTypeHouse;
    }
  }
}

enum ApartmentType {
  apartment,
  duplex,
  penhouse,
  service,
  dormitory,
  officetel;

  static ApartmentType parse(String value) {
    for (ApartmentType type in ApartmentType.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse ApartmentType! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case ApartmentType.apartment:
        return AppStrings.propertyTypeApartment;
      case ApartmentType.duplex:
        return AppStrings.apartmentTypeDuplex;
      case ApartmentType.penhouse:
        return AppStrings.apartmentTypePenhouse;
      case ApartmentType.service:
        return AppStrings.apartmentTypeService;
      case ApartmentType.dormitory:
        return AppStrings.apartmentTypeDormitory;
      case ApartmentType.officetel:
        return AppStrings.apartmentTypeOfficetel;
    }
  }
}

enum HouseType {
  frontHouse,
  townHouse,
  alleyHouse,
  villa,
  rowHouse;

  static HouseType parse(String value) {
    for (HouseType type in HouseType.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse HouseType");
  }

  @override
  String toString() {
    switch (this) {
      case HouseType.frontHouse:
        return AppStrings.houseTypeFrontHouse;
      case HouseType.townHouse:
        return AppStrings.houseTypeTownHouse;
      case HouseType.alleyHouse:
        return AppStrings.houseTypeAlleyHouse;
      case HouseType.villa:
        return AppStrings.houseTypeVilla;
      case HouseType.rowHouse:
        return AppStrings.houseTypeRowHouse;
    }
  }
}

enum OfficeType {
  office,
  officetel,
  commercialSpace,
  shopHouse;

  static OfficeType parse(String value) {
    for (OfficeType type in OfficeType.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse OfficeType! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case OfficeType.office:
        return AppStrings.officeTypeOffice;
      case OfficeType.officetel:
        return AppStrings.officeTypeOfficetel;
      case OfficeType.commercialSpace:
        return AppStrings.officeTypeCommercialSpace;
      case OfficeType.shopHouse:
        return AppStrings.officeTypeShopHouse;
    }
  }
}

enum Direction {
  north,
  south,
  east,
  west,
  northEast,
  northWest,
  southEast,
  southWest;

  @override
  String toString() {
    switch (this) {
      case Direction.north:
        return AppStrings.directionNorth;
      case Direction.south:
        return AppStrings.directionSouth;
      case Direction.east:
        return AppStrings.directionEast;
      case Direction.west:
        return AppStrings.directionWest;
      case Direction.northEast:
        return AppStrings.directionNorthEast;
      case Direction.northWest:
        return AppStrings.directionNorthWest;
      case Direction.southEast:
        return AppStrings.directionSouthEast;
      case Direction.southWest:
        return AppStrings.directionSouthWest;
    }
  }

  static Direction parse(String value) {
    for (Direction type in Direction.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse Direction! Your input value is \"$value\"");
  }
}

enum LandType {
  residential,
  agricultural,
  industrial,
  project;

  static LandType parse(String value) {
    for (LandType type in LandType.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse LandType! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case LandType.residential:
        return AppStrings.landTypeResidential;
      case LandType.agricultural:
        return AppStrings.landTypeAgricultural;
      case LandType.industrial:
        return AppStrings.landTypeIndustrial;
      case LandType.project:
        return AppStrings.landTypeProject;
    }
  }
}

enum LegalDocumentStatus {
  waitingForCertificate,
  haveCertificate,
  otherDocuments;

  static LegalDocumentStatus parse(String value) {
    for (LegalDocumentStatus type in LegalDocumentStatus.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse LegalDocumentStatus! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case LegalDocumentStatus.waitingForCertificate:
        return AppStrings.legalDocumentStatusWaitingForCertificate;
      case LegalDocumentStatus.haveCertificate:
        return AppStrings.legalDocumentStatusHaveCertificate;
      case LegalDocumentStatus.otherDocuments:
        return AppStrings.legalDocumentStatusOtherDocuments;
    }
  }
}

enum FurnitureStatus {
  empty,
  basic,
  full,
  highEnd;

  static FurnitureStatus parse(String value) {
    for (FurnitureStatus type in FurnitureStatus.values) {
      if (type.toString() == value) return type;
    }
    throw Exception(
        "Can't parse FurnitureStatus! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case FurnitureStatus.empty:
        return AppStrings.furnitureStatusEmpty;
      case FurnitureStatus.basic:
        return AppStrings.furnitureStatusBasic;
      case FurnitureStatus.full:
        return AppStrings.furnitureStatusFull;
      case FurnitureStatus.highEnd:
        return AppStrings.furnitureStatusHighEnd;
    }
  }
}

enum OrderBy {
  priceAsc,
  priceDesc,
  createdAtAsc,
  createdAtDesc;

  String get filterString =>
      (this == priceAsc || this == priceDesc) ? 'price' : 'posted_date';

  bool get isAsc => this == priceAsc || this == createdAtAsc;
}

enum PostedBy {
  all,
  proSeller,
  individual;

  List<bool> toFilterList() {
    switch (this) {
      case PostedBy.all:
        return [true, false];
      case PostedBy.proSeller:
        return [true];
      case PostedBy.individual:
        return [false];
    }
  }
}

enum HandOverFilter {
  all,
  completed,
  pending,
}

enum HouseAndLandFeatureFilter {
  all,
  hasWideAlley,
  isFacade,
}
