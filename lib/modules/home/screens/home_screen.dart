import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/global_widgets/infor_card.dart';
import 'package:nha_gia_re/modules/home/widgets/button.dart';
import 'package:nha_gia_re/global_widgets/carousel_ad.dart';
import 'package:nha_gia_re/modules/home/widgets/icon_notification.dart';
import 'package:nha_gia_re/modules/home/widgets/image_button.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import '../../../core/values/filter_values.dart';
import '../../../data/enums/enums.dart';
import '../../../data/models/properties/post.dart';
import '../../search/widgets/my_search_delegate.dart';
import '../home_controller.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MySearchDelegate _delegate;
  final HomeController _controller = Get.find<HomeController>();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _delegate = MySearchDelegate();
  }

  void onChangedTextFiled() async {
    FocusScope.of(context).unfocus();
    searchController.clear();
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
            controller: searchController,
            onTap: onChangedTextFiled,
            onChanged: (value) {
              onChangedTextFiled();
            },
          ),
        ),
        actions: [
          StreamBuilder(
              stream: GetIt.instance<ChatRepository>().conversationStream,
              builder: (context, snapShot) {
                final conversations = snapShot.data ?? [];
                final unreadConversations = conversations
                    .where(
                        (conversation) => conversation.numOfUnReadMessage != 0)
                    .toList();
                RxInt unreadCount = unreadConversations.length.obs;

                return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.conversation);
                    },
                    child: Obx(
                      () => unreadCount.value == 0
                          ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(Assets.messCircle, width: 25),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(top: 13, right: 13),
                              child: badges.Badge(
                                position: badges.BadgePosition.topStart(
                                    top: -8, start: 18),
                                badgeContent: Text(
                                  unreadCount.value.toString(),
                                  style: AppTextStyles.roboto11Bold.copyWith(color: AppColors.white),
                                ),
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: AppColors.red,
                                ),
                                child: Image.asset(Assets.messCircle, width: 25),
                              ),
                            ),
                    ));
              }),
          GestureDetector(
            onTap: () {
              _controller.navToNoti();
            },
            child: const IconNotification(),
          ),
        ],
      ),
      body: FutureBuilder<List<List<Post>>>(
          future: _controller.init(),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<List<Post>> data = snapShot.data!;
              return SingleChildScrollView(
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
                            icon: Image.asset(Assets.coin),
                            title: 'For Sale'.tr,
                            onPressed: () {
                              _controller.navToSell();
                            },
                          ),
                          CustomButton(
                            icon: Image.asset(Assets.key),
                            title: 'For Lease'.tr,
                            onPressed: () {
                              _controller.navToRent();
                            },
                          ),
                          CustomButton(
                            icon: Image.asset(Assets.edit_color),
                            title: 'Post'.tr,
                            onPressed: _controller.navToPost,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Provinces'.tr,
                            style: AppTextStyles.roboto20Bold,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 250,
                            child: GridView(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200, // chieu cao
                                        mainAxisExtent: 125, // chieu rong
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                children: FilterValues.instance.provinces
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  int i = e.key;
                                  String title = e.value;
                                  return ImageButton(i, title);
                                }).toList()),
                          )
                        ],
                      ),
                    ),
                    if(data[1].isNotEmpty) InforCardList(
                      title: 'Gần bạn',
                      list: data[1],
                      navType: TypeNavigate.province,
                      province: _controller.userInfo?.address?.cityName,
                    ),
                    InforCardList(
                      title: 'Nhà cho thuê',
                      list: data.first,
                      navType: TypeNavigate.rent,
                    ),
                    InforCardList(
                      title: 'Nhà bán',
                      list: data.last,
                      navType: TypeNavigate.sell,
                    ),
                    const SizedBox(
                      height: 17,
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
