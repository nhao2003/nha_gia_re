import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/global_widgets/infor_card.dart';
import 'package:nha_gia_re/modules/home/widgets/button.dart';
import 'package:nha_gia_re/modules/home/widgets/carousel_ad.dart';
import 'package:nha_gia_re/modules/home/widgets/image_button.dart';
import 'package:nha_gia_re/routers/app_pages.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import '../../search/widgets/my_search_delegate.dart';
import '../home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MySearchDelegate _delegate;
  final HomeController _controller = Get.find<HomeController>();
  final searchControler = TextEditingController();
  @override
  void initState() {
    super.initState();
    _delegate = MySearchDelegate();
  }

  void onChangedTextFiled() async {
    FocusScope.of(context).unfocus();
    searchControler.clear();
    await showSearch<String>(
      context: context,
      delegate: _delegate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search...'.tr,
              border: InputBorder.none,
            ),
            controller: searchControler,
            onTap: onChangedTextFiled,
            onChanged: (value) {
              onChangedTextFiled();
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.conversation);
            },
            icon: Image.asset(Assets.messCircle, width: 24),
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselAd(
              imgList: _controller.imgList,
              aspectRatio: 2.59,
              indicatorSize: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    icon: Image.asset(Assets.thunder),
                    title: 'Mua bán',
                  ),
                  CustomButton(
                    icon: Image.asset(Assets.arrow),
                    title: 'Cho thuê',
                  ),
                  CustomButton(
                      icon: Image.asset(Assets.edit_color), title: 'Đăng bài'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gần bạn',
                    style: AppTextStyles.roboto20Bold,
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: const [
                      ImageButton(),
                      ImageButton(),
                      ImageButton(),
                      ImageButton(),
                      ImageButton(),
                      ImageButton(),
                    ],
                  ),
                ],
              ),
            ),
            const InforCardList(title: 'Gần bạn', list: []),
            const InforCardList(title: 'Nhà bán', list: []),
            const InforCardList(title: 'Nhà cho thuê', list: []),
          ],
        ),
      ),
    );
  }
}
