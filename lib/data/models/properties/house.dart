import '../address.dart';
import 'post.dart';

class House extends Post {
  bool hasWideAlley;
  bool isFacade;
  bool isWidensTowardsTheBack;
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
    required this.furnitureStatus,
    required double area,
    required String? projectName,
    required this.hasWideAlley,
    required this.isFacade,
    required this.isWidensTowardsTheBack,
    required this.areaUsed,
    required this.width,
    required this.length,
    required this.houseType,
    required this.numOfBedRooms,
    required this.numOfToilets,
    required this.numOfFloors,
    required this.mainDoorDirection,
    required this.legalDocumentStatus,
    required Address address,
    required PropertyType type,
    required String userID,
    required bool isLease,
    required int price,
    required String title,
    required String description,
    required DateTime postedDate,
    required DateTime expiryDate,
    required List<String> imagesUrl,
    required bool isProSeller,
    required int? deposit,
    required int numOfLikes,
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
          postedDate: postedDate,
          expiryDate: expiryDate,
          imagesUrl: imagesUrl,
          isProSeller: isProSeller,
          projectName: projectName,
          deposit: deposit,
          numOfLikes: numOfLikes,
        );

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      id: json['id'],
      area: json['area'],
      type: PropertyType.parse(json['property_type']),
      address: Address.fromJson(json['address']),
      userID: json['user_id'],
      isLease: json['is_lease'],
      price: json['price'],
      title: json['title'],
      description: json['description'],
      postedDate: DateTime.parse(json['posted_date']),
      expiryDate: DateTime.parse(json['expiry_date']),
      imagesUrl: List<String>.from(json['images_url']),
      isProSeller: json['is_pro_seller'],
      projectName: json['project_name'],
      deposit: json['deposit'],
      numOfLikes: json['num_of_likes'],
      hasWideAlley: json['has_wide_alley'],
      isFacade: json['is_facade'],
      isWidensTowardsTheBack: json['is_widens_towards_the_back'],
      houseType: json['house_type'] != null
          ? HouseType.parse(json['house_type'])
          : null,
      mainDoorDirection: json['main_door_direction'] != null
          ? Direction.parse(json['main_door_direction'])
          : null,
      legalDocumentStatus: json['legal_document_status'] != null
          ? LegalDocumentStatus.parse(json['legal_document_status'])
          : null,
      furnitureStatus: json['furniture_status'] != null
          ? FurnitureStatus.parse(json['furniture_status'])
          : null,
      areaUsed: json['area_used'],
      width: json['width']?.toDouble(),
      length: json['length']?.toDouble(),
      numOfBedRooms: json['nums_of_bed_rooms'],
      numOfToilets: json['nums_of_toilets'],
      numOfFloors: json['nums_of_floors'],
    );
  }
  @override
  String toString() {
    return 'House{'
        'id: $id, '
        'furnitureStatus: $furnitureStatus, '
        'area: $area, '
        'price: $price'
        'projectName: $projectName, '
        'hasWideAlley: $hasWideAlley, '
        'isFacade: $isFacade, '
        'areaUsed: $areaUsed, '
        'width: $width, '
        'length: $length, '
        'houseType: $houseType, '
        'numOfBedRooms: $numOfBedRooms, '
        'numOfToilets: $numOfToilets, '
        'numOfFloors: $numOfFloors, '
        'mainDoorDirection: $mainDoorDirection, '
        'legalDocumentStatus: $legalDocumentStatus, '
        'address: $address, '
        '${super.toString()}'
        '}';
  }
}
