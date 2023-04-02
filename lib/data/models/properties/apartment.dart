import '../address.dart';
import 'post.dart';

class Apartment extends Post {
  bool? isCorner;
  bool? isHandOver;
  int? numOfBedRooms;
  Direction? balconyDirection;
  Direction? mainDoorDirection;
  int? numOfToilets;
  String? block;
  int floor;
  ApartmentType? apartmentType;
  LegalDocumentStatus? legalDocumentStatus;
  FurnitureStatus? furnitureStatus;
  Apartment({
    required String id,
    this.furnitureStatus,
    required double area,
    String? projectName,
    this.apartmentType,
    this.isCorner,
    this.isHandOver,
    this.numOfBedRooms,
    this.balconyDirection,
    this.mainDoorDirection,
    this.numOfToilets,
    this.block,
    this.legalDocumentStatus,
    required this.floor,
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
  })  : assert(numOfBedRooms == null || numOfBedRooms >= 0),
        assert(numOfToilets == null || numOfToilets >= 0),
        assert(block == null || block.trim().isNotEmpty),
        assert(floor >= 0),
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
