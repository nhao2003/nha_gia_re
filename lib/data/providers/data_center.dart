import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/models/product.dart';
import '../models/properties/post.dart';
import '../models/user_info.dart';

class DataCenter {
  static final DataCenter instance = DataCenter._internal();

  factory DataCenter() {
    return instance;
  }

  DataCenter._internal();

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
