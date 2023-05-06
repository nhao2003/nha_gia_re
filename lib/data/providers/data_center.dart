import 'package:nha_gia_re/data/models/address.dart';
import '../enums/enums.dart';
import '../models/properties/post.dart';

class DataCenter {
  static final DataCenter instance = DataCenter._internal();

  factory DataCenter() {
    return instance;
  }

  DataCenter._internal();

  List<Post> listPosts = [
    Post(
      id: "1",
      area: 100,
      type: PropertyType.apartment,
      address: Address(cityCode: 1, districtCode: 1, wardCode: 1),
      userID: "user1",
      isLease: true,
      price: 10000000,
      title: "Luxury Condo in the heart of the city",
      description:
          "This stunning condo features high ceilings, floor-to-ceiling windows, and panoramic views of the city skyline. The open floor plan is perfect for entertaining and the modern kitchen is a chef's dream.",
      postedDate: DateTime(2022, 3, 10),
      expiryDate: DateTime(2022, 9, 30),
      imagesUrl: [
        "https://thietkethicongnhadep.net/wp-content/uploads/2015/10/thiet-ke-phong-tro-20m2.jpg",
        "https://example.com/image8.jpg",
        "https://example.com/image9.jpg",
      ],
      isProSeller: true,
      projectName: "abc",
      deposit: 100000,
      numOfLikes: 3,
    ),
    Post(
      id: "2",
      area: 150,
      type: PropertyType.house,
      address: Address(cityCode: 2, districtCode: 2, wardCode: 2),
      userID: "user2",
      isLease: false,
      price: 5000000,
      title: "Stunning Modern House with Ocean View",
      description:
          "This contemporary house features sleek design and breathtaking ocean views. The expansive outdoor space includes a pool, hot tub, and fire pit. The interior is filled with natural light and features high-end finishes and appliances.",
      postedDate: DateTime(2022, 4, 1),
      expiryDate: DateTime(2022, 10, 31),
      imagesUrl: [
        "https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2021/11/16/cho-thue-phong-tro-1613975723_1637034014.jpg",
        "https://example.com/image11.jpg",
        "https://example.com/image12.jpg",
      ],
      isProSeller: false,
      projectName: null,
      deposit: null,
      numOfLikes: 8,
    ),
    Post(
      id: "3",
      area: 80,
      type: PropertyType.land,
      address: Address(cityCode: 3, districtCode: 3, wardCode: 3),
      userID: "user3",
      isLease: true,
      price: 5000,
      title: "Cozy Condo with Great Location",
      description:
          "This charming condo is located in the heart of the city and has easy access to public transportation. The interior is updated with modern finishes and the building has a fitness center and a rooftop deck with views of the skyline.",
      postedDate: DateTime(2022, 5, 15),
      expiryDate: DateTime(2022, 11, 30),
      imagesUrl: [
        "https://toancanhbatdongsan.com.vn/uploads/images/blog/hoangvy/2022/06/02/cho-thue-phong-tro-1654136735.jpeg",
        "https://example.com/image14.jpg",
        "https://example.com/image15.jpg",
      ],
      isProSeller: false,
      projectName: "XYZ",
      deposit: 1000,
      numOfLikes: 2,
    ),
    Post(
      id: "4",
      area: 200,
      type: PropertyType.motel,
      address: Address(cityCode: 4, districtCode: 4, wardCode: 4),
      userID: "user4",
      isLease: false,
      price: 8000000,
      title: "Luxury House with Private Pool",
      description:
          "This luxurious house features a spacious floor plan, high-end finishes, and a private pool and hot tub. The outdoor space is perfect for entertaining and the master suite includes a spa-like bathroom and a walk-in closet.",
      postedDate: DateTime(2022, 6, 10),
      expiryDate: DateTime(2022, 12, 31),
      imagesUrl: [
        "https://storage.googleapis.com/digital-platform/hinh_anh_nam_long_kinh_nghiem_thue_phong_tro_danh_cho_sinh_vien_so_1_ec29cfda91/hinh_anh_nam_long_kinh_nghiem_thue_phong_tro_danh_cho_sinh_vien_so_1_ec29cfda91.png",
        "https://example.com/image17.jpg",
        "https://example.com/image18.jpg",
      ],
      isProSeller: true,
      projectName: "PQR",
      deposit: 200000,
      numOfLikes: 12,
    ),
  ];
}
