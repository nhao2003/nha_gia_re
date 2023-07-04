import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/global_widgets/infor_card.dart';
import 'package:nha_gia_re/global_widgets/carousel_ad.dart';
import 'package:nha_gia_re/modules/post_details/post_detail_controller.dart';
import 'package:nha_gia_re/modules/post_details/widget/expandable_container.dart';

import '../../../data/enums/enums.dart';
class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final PostDetailController _controller = PostDetailController();
  @override
  void initState() {
    super.initState();
    print(Get.arguments);
    _controller.initArg(Get.arguments);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.post.title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _controller.init(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _controller.post = snapshot.data?[1];
            Future.delayed(Duration.zero).then((value) {
              // your obx var, eg. global_variables.appBarTitle.value = "Messages";   
              _controller.numOfLikes.value = _controller.post.numOfLikes;
              _controller.liked.value = snapshot.data?[2];
            });
            _controller.userInfo = snapshot.data?.first;
            _controller.relatedPost = snapshot.data?.last;
            print(snapshot.data);
            return SingleChildScrollView(
              child: Column(children: [
                CarouselAd(
                    imgList: _controller.post.imagesUrl,
                    aspectRatio: 1.72,
                    indicatorSize: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _controller.post.title,
                          style: AppTextStyles.roboto20semiBold,
                        ),
                        Row(
                          children: [
                            Text(
                              _controller.post.price.toFormattedMoney(
                                  isLease: _controller.post.isLease),
                              style: AppTextStyles.roboto20semiBold
                                  .copyWith(color: AppColors.red),
                            ),
                            Text(' - ${_controller.post.area}m2',
                                style: AppTextStyles.roboto20regular),
                            const Spacer(),
                            Obx(() => IconButton(
                                onPressed:( _controller.likePost),
                                icon: (_controller.liked.value) 
                                  ? Icon(Icons.favorite, color: AppColors.red,)
                                  : const Icon(Icons.favorite_border_outlined,)
                                )),
                            Obx(() => Text(_controller.numOfLikes.value.toString(),style: AppTextStyles.roboto18regular)),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              Assets.map_pin,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                width: 320,
                                child: Text(
                                  _controller.post.address.toString(),
                                  maxLines: 2,
                                  style: AppTextStyles.roboto16regular,
                                  overflow: TextOverflow.ellipsis,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              Assets.clock,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              _controller.post.postedDate.getTimeAgo(),
                              style: AppTextStyles.roboto16regular,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  CachedNetworkImageProvider( _controller.userInfo.avatarUrl! ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _controller.userInfo.fullName!,
                                    style: AppTextStyles.roboto16semiBold,
                                  ),
                                  Text(
                                    (_controller.post.isProSeller)
                                        ? "Agency".tr
                                        : "Independence".tr,
                                    style: AppTextStyles.roboto14regular,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: _controller.navToUserProfile,
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.fromLTRB(
                                                20, 10, 20, 10)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: AppColors.primaryColor)))),
                                child: Text('View profile'.tr)),
                          ],
                        ),
                      ]),
                ),
                ExpandableContainer(
                  title: 'Real estate features'.tr,
                  minHeight: 130,
                  child: _controller.postDetail(_controller.post),
                ),
                ExpandableContainer(
                  title: 'Description'.tr,
                  minHeight: 114,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Text(
                      _controller.post.description,
                      style: AppTextStyles.roboto16regular,
                    ),
                  ),
                ),
                InforCardList(title: 'Related'.tr, list: _controller.relatedPost, navType: TypeNavigate.province, province: _controller.post.address.cityName,)
              ]),
            );
          }
        },
      ),

      bottomNavigationBar: (!_controller.isYourPost) ?
       BottomAppBar(
          child: SizedBox(
        height: 80,
        child: Row(children: [
          Expanded(
              child: MaterialButton(
                  onPressed: _controller.launchPhone,
                  color: AppColors.green,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone_in_talk_outlined,
                          size: 24,
                          color: Colors.white,
                        ),
                        Text(
                          'Call'.tr,
                          style: AppTextStyles.roboto12regular
                              .copyWith(color: Colors.white),
                        )
                      ]))),
          Expanded(
              child: MaterialButton(
                  onPressed: _controller.navToChat,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.messCircle,
                          width: 24,
                          color: AppColors.green,
                        ),
                        Text(
                          'Chat'.tr,
                          style: AppTextStyles.roboto12regular
                              .copyWith(color: AppColors.green),
                        )
                      ]))),
          Expanded(
              child: MaterialButton(
                  onPressed: _controller.launchSms,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sms_outlined,
                          size: 24,
                          color: AppColors.green,
                        ),
                        Text(
                          'SMS messages'.tr,
                          style: AppTextStyles.roboto12regular
                              .copyWith(color: AppColors.green),
                        )
                      ])))
        ]),
      ))
      : null,
    );
  }
}
