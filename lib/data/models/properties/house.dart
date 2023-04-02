import '../address.dart';
import 'post.dart';

class House extends Post {
  bool? hasWideAlley;
  bool? isFacade;
  double? areaUsed;
  HouseType? houseType;
  double? width;
  double? length;
  int? numOfBedRooms;
  int? numOfToilets;
  int? numOfFloors;
  Direction? mainDoorDirection;
  LegalDocumentStatus? legalDocumentStatus;
  FurnitureStatus? furnitureStatus;
  House({
    required String id,
    this.furnitureStatus,
    required double area,
    String? projectName,
    this.hasWideAlley,
    this.isFacade,
    this.areaUsed,
    this.width,
    this.length,
    this.houseType,
    this.numOfBedRooms,
    this.numOfToilets,
    this.numOfFloors,
    this.mainDoorDirection,
    this.legalDocumentStatus,
    required Address address,
    required PropertyType type,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required DateTime postedAt,
    required DateTime expiryDate,
    required List<String> imagesUrl,
    required bool isProSeller,
    int? deposit,
    int numOfFavs = 0,
  })  : assert(areaUsed == null || areaUsed > 0),
        assert((width == null && length == null) ||
            (width != null && length != null && width * length > 0)),
        assert(numOfBedRooms == null || numOfBedRooms >= 0),
        assert(numOfToilets == null || numOfToilets >= 0),
        assert(numOfFloors == null || numOfFloors >= 0),
        super(
          id: id,
          area: area,
          type: type,
          address: address,
          userID: userID,
          isLease: isLease,
          price: price,
          title: title,
          description: description,
          postedAt: postedAt,
          expiryDate: expiryDate,
          imagesUrl: imagesUrl,
          isProSeller: isProSeller,
          projectName: projectName,
          deposit: deposit,
          numOfFavs: numOfFavs,
        );
}
