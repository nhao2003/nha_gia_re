import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/models/product.dart';
import '../models/post.dart';
import '../models/properties/property.dart';
import '../models/user_info.dart';

class DataCenter {
  static final DataCenter instance = DataCenter._internal();

  factory DataCenter() {
    return instance;
  }

  DataCenter._internal();

  List<Post> dummyPosts = [
    Post(
      id: '1',
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      userID: 'user123',
      isLease: false,
      price: 200000,
      title: 'Beautiful Home for Sale',
      description:
          'This is a gorgeous 3 bedroom, 2 bathroom home with a spacious yard and great natural lighting. Come see it today!',
      postedAt: DateTime(2022, 5, 15),
      expiryDate: DateTime(2022, 7, 15),
      imagesUrl: [
        'https://picsum.photos/900/600',
        'https://picsum.photos/900/600'
      ],
      isProSeller: true,
      propertyID: '001',
      numOfFavs: 10,
    ),
    Post(
      id: '2',
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      userID: 'user456',
      isLease: true,
      deposit: 1000,
      price: 1500,
      title: 'Cozy Apartment for Lease',
      description:
          'This is a lovely 1 bedroom, 1 bathroom apartment with a great location and easy access to public transportation. Apply today!',
      postedAt: DateTime(2022, 6, 1),
      expiryDate: DateTime(2022, 9, 1),
      imagesUrl: [
        'https://picsum.photos/900/600',
        'https://picsum.photos/900/600'
      ],
      isProSeller: false,
      numOfFavs: 5,
      propertyID: '002',
    ),
    Post(
      id: '3',
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      userID: 'user789',
      isLease: false,
      price: 500000,
      title: 'Spacious House for Sale',
      description:
          'This is a beautiful 4 bedroom, 3 bathroom home with a large backyard and plenty of room for a family. Don\'t miss out!',
      postedAt: DateTime(2022, 7, 1),
      expiryDate: DateTime(2022, 10, 1),
      imagesUrl: [
        'https://picsum.photos/900/600',
        'https://picsum.photos/900/600'
      ],
      isProSeller: true,
      propertyID: '003',
      numOfFavs: 15,
    ),
    Post(
      id: '4',
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      userID: 'user321',
      isLease: false,
      price: 750000,
      title: 'Luxury Condo for Sale',
      description:
          'This is a stunning 2 bedroom, 2 bathroom condo with high-end finishes and beautiful views of the city. Schedule a showing today!',
      postedAt: DateTime(2022, 8, 1),
      expiryDate: DateTime(2022, 11, 1),
      imagesUrl: [
        'https://picsum.photos/900/600',
        'https://picsum.photos/900/600'
      ],
      isProSeller: true,
      propertyID: '004',
      numOfFavs: 20,
    ),
    Post(
      id: '5',
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      userID: 'user555',
      isLease: true,
      deposit: 500,
      price: 1200,
      title: 'Affordable Apartment for Lease',
      description:
          'This is a cozy 1 bedroom, 1 bathroom apartment with easy access to shopping and dining. Apply today!',
      postedAt: DateTime(2022, 9, 1),
      expiryDate: DateTime(2022, 12, 1),
      imagesUrl: [
        'https://picsum.photos/900/600',
        'https://picsum.photos/900/600'
      ],
      isProSeller: false,
      numOfFavs: 8,
      propertyID: '005',
    ),
    Post(
      id: '6',
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      userID: 'user777',
      isLease: false,
      price: 1000000,
      title: 'Mansion for Sale',
      description:
          'This is a truly unique 6 bedroom, 4 bathroom mansion with exquisite details and a beautiful pool. You must see it to believe it!',
      postedAt: DateTime(2022, 10, 1),
      expiryDate: DateTime(2022, 12, 31),
      imagesUrl: [
        'https://picsum.photos/900/600',
        'https://picsum.photos/900/600'
      ],
      isProSeller: true,
      propertyID: '006',
      numOfFavs: 30,
    ),
    Post(
      id: '7',
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      userID: 'user999',
      isLease: false,
      price: 300000,
      title: 'Cozy Cottage for Sale',
      description:
          'This is a charming 2 bedroom, 1 bathroom cottage with a fireplace and a beautiful garden. It\'s the perfect place to call home!',
      postedAt: DateTime(2022, 11, 1),
      expiryDate: DateTime(2023, 2, 1),
      imagesUrl: [
        'https://picsum.photos/900/600',
        'https://picsum.photos/900/600'
      ],
      isProSeller: false,
      propertyID: '007',
      numOfFavs: 12,
    ),
  ];
  List<UserInfo> users = [
    UserInfo(
      uid: 'user123',
      isMale: true,
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      fullName: 'John Doe',
      createdAt: DateTime(2022, 1, 1),
      phoneNumber: '123-456-7890',
      birthday: DateTime(1990, 1, 1),
      email: 'johndoe@example.com',
      description: 'I am a software engineer who loves to code!',
      avatarUrl: 'https://picsum.photos/900/600',
    ),
    UserInfo(
      uid: 'user456',
      isMale: false,
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      fullName: 'Jane Smith',
      createdAt: DateTime(2022, 2, 1),
      phoneNumber: '555-555-5555',
      birthday: DateTime(1985, 6, 1),
      email: 'janesmith@example.com',
      avatarUrl: 'https://picsum.photos/900/600',
    ),
    UserInfo(
      uid: 'user789',
      isMale: true,
      address: Address(cityCode: 100, districtCode: 100, wardCode: 100),
      fullName: 'Bob Johnson',
      createdAt: DateTime(2022, 3, 1),
      phoneNumber: '777-777-7777',
      birthday: DateTime(1978, 10, 1),
      email: 'bobjohnson@example.com',
      description: 'I am a musician who loves to play guitar!',
      avatarUrl: 'https://picsum.photos/900/600',
    ),
  ];
  final List<Property> properties = [
    Apartment(
      id: '001',
      area: 100,
      projectName: 'Apartment Complex A',
      isCorner: true,
      isHandOver: true,
      apartmentType: ApartmentType.duplex,
      numOfBedRooms: 2,
      balconyDirection: Direction.east,
      mainDoorDirection: Direction.south,
      numOfToilets: 1,
      block: 'A1',
      floor: 10,
    ),
    House(
      id: '002',
      houseType: HouseType.alleyHouse,
      area: 200,
      projectName: 'Housing Estate B',
      hasWideAlley: true,
      isFacade: false,
      areaUsed: 180,
      width: 10.0,
      length: 20.0,
      numOfBedRooms: 3,
      numOfToilets: 2,
      numOfFloors: 2,
      mainDoorDirection: Direction.south,
      legalDocumentStatus: LegalDocumentStatus.haveCertificate,
    ),
    Land(
      id: '003',
      furnitureStatus: null,
      area: 300,
      projectName: null,
      landLotCode: '001A',
      subdivisionName: 'Residential Area C',
      landType: LandType.residential,
      width: 30.0,
      length: 10.0,
      landDirection: Direction.north,
      legalDocumentStatus: LegalDocumentStatus.waitingForCertificate,
      isFacade: true,
      isWidensTowardsTheBack: false,
      hasWideAlley: false,
    ),
    Motel(
      id: '004',
      furnitureStatus: FurnitureStatus.full,
      area: 150,
      projectName: 'Motel D',
      electricPrice: 20000,
      waterPrice: 10000,
    ),
    Office(
      id: '005',
      furnitureStatus: FurnitureStatus.highEnd,
      area: 80,
      projectName: 'Office Building E',
      hasWideAlley: false,
      isFacade: true,
      officeType: OfficeType.commercialSpace,
      mainDoorDirection: Direction.southEast,
      legalDocumentStatus: LegalDocumentStatus.otherDocuments,
    ),
    Apartment(
      id: '006',
      area: 80,
      floor: 3,
      apartmentType: ApartmentType.officetel,
      numOfBedRooms: 2,
      balconyDirection: Direction.southWest,
      mainDoorDirection: Direction.northEast,
      numOfToilets: 2,
      projectName: 'ABC Apartment',
    ),
    House(
      id: '007',
      area: 120,
      hasWideAlley: true,
      isFacade: true,
      houseType: HouseType.frontHouse,
      width: 5,
      length: 24,
      numOfBedRooms: 3,
      numOfToilets: 3,
      numOfFloors: 3,
      mainDoorDirection: Direction.northWest,
      legalDocumentStatus: LegalDocumentStatus.haveCertificate,
    ),
    Land(
      id: '008',
      area: 200,
      width: 10,
      length: 20,
      landDirection: Direction.east,
      landType: LandType.industrial,
      legalDocumentStatus: LegalDocumentStatus.otherDocuments,
      subdivisionName: 'ABC Subdivision',
      hasWideAlley: true,
    ),
    Motel(
      id: '009',
      area: 150,
      electricPrice: 5000,
      waterPrice: 500,
    ),
    Office(
      id: '010',
      area: 100,
      officeType: OfficeType.commercialSpace,
      hasWideAlley: true,
      isFacade: true,
      mainDoorDirection: Direction.southEast,
      legalDocumentStatus: LegalDocumentStatus.otherDocuments,
    ),
  ];

  List<Product> products = [
    Product(
      title: "Nhà sổ hồng riêng 5x15 ngã 3 Mỹ Hạnh, Đức Hoà, LA",
      money: "1,2 tỷ",
      size: "100m2",
      location: "Long An",
      timeCreated: "15 phút trước",
      urlImage:
          "https://toancanhbatdongsan.com.vn/uploads/images/blog/hoangvy/2022/06/02/cho-thue-phong-tro-1654136735.jpeg",
    ),
    Product(
      title: "Nhà sổ hồng riêng 5x15 ngã 3 Mỹ Hạnh, Đức Hoà, LA",
      money: "1,2 tỷ",
      size: "100m2",
      location: "Long An",
      timeCreated: "15 phút trước",
      urlImage:
          "https://blog.rever.vn/hubfs/cho_thue_phong_tro_moi_xay_gia_re_ngay_phuong_15_tan_binh3.jpg",
    ),
    Product(
      title: "Nhà sổ hồng riêng 5x15 ngã 3 Mỹ Hạnh, Đức Hoà, LA",
      money: "1,2 tỷ",
      size: "100m2",
      location: "Long An",
      timeCreated: "15 phút trước",
      isFavourited: true,
      urlImage:
          "https://trongoixaynha.com/wp-content/uploads/2021/07/xay-phong-tro-gia-bao-nhieu-3.jpg",
    ),
    Product(
      title: "Nhà sổ hồng riêng 5x15 ngã 3 Mỹ Hạnh, Đức Hoà, LA",
      money: "1,2 tỷ",
      size: "100m2",
      location: "Long An",
      timeCreated: "15 phút trước",
      urlImage:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHQCGTZ0F7s2X_As5QHMmI18F8e2498bXU_A&usqp=CAU",
    ),
    Product(
      title: "Nhà sổ hồng riêng 5x15 ngã 3 Mỹ Hạnh, Đức Hoà, LA",
      money: "1,2 tỷ",
      size: "100m2",
      location: "Long An",
      timeCreated: "15 phút trước",
      urlImage:
          "https://storage.googleapis.com/digital-platform/hinh_anh_nam_long_kinh_nghiem_thue_phong_tro_danh_cho_sinh_vien_so_1_ec29cfda91/hinh_anh_nam_long_kinh_nghiem_thue_phong_tro_danh_cho_sinh_vien_so_1_ec29cfda91.png",
    ),
    Product(
      title: "Nhà sổ hồng riêng 5x15 ngã 3 Mỹ Hạnh, Đức Hoà, LA",
      money: "1,2 tỷ",
      size: "100m2",
      location: "Long An",
      timeCreated: "15 phút trước",
      urlImage:
          "https://file4.batdongsan.com.vn/2022/08/26/PHJN6Zw0/20220826100833-50e4.jpg",
    ),
    Product(
      title: "Nhà sổ hồng riêng 5x15 ngã 3 Mỹ Hạnh, Đức Hoà, LA",
      money: "1,2 tỷ",
      size: "100m2",
      location: "Long An",
      timeCreated: "15 phút trước",
      urlImage:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwav1jRqhk9ObbDUnjs5TfAF56YZC6Vd5XrA&usqp=CAU",
    ),
  ];
}
