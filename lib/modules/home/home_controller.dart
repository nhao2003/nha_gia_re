import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/request/filter_request.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import '../../data/models/properties/post.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  // code controller here
  // define variable and function
  final String fakeUrl = 'https://flutter.dev';

  final List<String> imgList = [
    'https://cdn.chotot.com/admincentre/D7Le2XZDgAF07oJDVyc_Gz765rWVQ5c8hwXonwYWapg/preset:raw/plain/a54ed308183c261c8529a6729ef4512c-2812912165257461362.jpg',
    'https://cdn.chotot.com/admincentre/ctc6HtBG1QICBtN5KQNCNO34k73kZn9gQLxmhOjfWw4/preset:raw/plain/1bfd526b0b6c995da1c20eb5f3ba0c51-2805772162331331393.jpg',
    'https://cdn.chotot.com/admincentre/ICGqIPhBAn559vSI4v7jaBAYFYegeRG7xSfUJ6tkugI/preset:raw/plain/6ec3994f81e14d768dfc467847ce430c-2820195948173896828.jpg',
    'https://cdn.chotot.com/admincentre/83O9GjTqqxMohxXA1DcGEojtznUAIxJYWwTDMhhWp88/preset:raw/plain/bb0f1e32befe115598c292f0b7434fe7-2829010373569559918.jpg',
    'https://cdn.chotot.com/admincentre/586665ff-021b-4eb2-a0a2-acf2405ebedc_banner.jpg',
  ];

  void launchWebURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  PostRepository repository = PostRepository();
  UserInfo? userInfo;

  void navToPost() {
    Get.toNamed(AppRoutes.post);
  }

  void navToSell() {
    var data = {
      "title": 'Mua bán',
      "type": TypeNavigate.sell,
    };
    Get.toNamed(AppRoutes.resultArg, arguments: data);
  }

  void navToRent() {
    var data = {
      "title": 'Cho thuê',
      "type": TypeNavigate.rent,
    };
    Get.toNamed(AppRoutes.resultArg, arguments: data);
  }

  void navByProvince(String provider) {
    var data = {
      "title": 'Tỉnh thành',
      "type": TypeNavigate.province,
      "province": provider,
    };
    Get.toNamed(AppRoutes.resultArg, arguments: data);
  }

  Future<List<List<Post>>> init() async {
    AuthRepository authRepository = AuthRepository();
    late List<List<Post>> data;
    await authRepository.getUserInfo().then((value) async {
      PostRepository repository = PostRepository();
      PostFilter filter = PostFilter(
        orderBy: OrderBy.priceAsc,
        postedBy: PostedBy.all,
        provinceCode: value.address?.cityCode,
        from: 0,
        to: 10,
      );
      userInfo = value;
      data = await Future.wait([getLeasePosts(), repository.getAllPosts(filter),  getSellPosts()]);
    }
    );        
    print("Data Length: ${data.length}");
    return data;
  }

  Future<List<Post>> getLeasePosts() async {
    return await repository.getAllPosts(PostFilter(
      isLease: true,
      orderBy: OrderBy.createdAtDesc,
      postedBy: PostedBy.all,
      from: 0,
      to: 10,
    ));
  }

  Future<List<Post>> getSellPosts() async {
    return await repository.getAllPosts(PostFilter(
      isLease: false,
      orderBy: OrderBy.createdAtDesc,
      postedBy: PostedBy.all,
      from: 0,
      to: 10,
    ));
  }
}
