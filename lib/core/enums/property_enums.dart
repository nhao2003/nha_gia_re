import 'package:nha_gia_re/core/values/app_strings.dart';

enum PropertyType {
  apartment,
  land,
  office,
  motel,
  house;

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
  duplex,
  penhouse,
  service,
  dormitory,
  officetel;

  @override
  String toString() {
    switch (this) {
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
}

enum LandType {
  residential,
  agricultural,
  industrial,
  project;

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
