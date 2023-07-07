import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/global_widgets/carousel_ad.dart';
import 'package:nha_gia_re/modules/admin_post_detail/admin_post_detail_controller.dart';
import 'package:nha_gia_re/modules/admin_post_manage/admin_post_controller.dart';
import 'package:nha_gia_re/modules/post_details/post_detail_controller.dart';
import 'package:nha_gia_re/modules/post_details/widget/expandable_container.dart';

class AdminPostDetailScreen extends StatefulWidget {
  const AdminPostDetailScreen({super.key});

  @override
  _AdminPostDetailScreenState createState() => _AdminPostDetailScreenState();
}

class _AdminPostDetailScreenState extends State<AdminPostDetailScreen> {
  final AdminPostController parentController = Get.find<AdminPostController>();
  final AdminPostDetailController _controller =
      Get.find<AdminPostDetailController>();
  TextEditingController messageController = TextEditingController();
  List<String> checkListItems = [
    "Bài đăng bị trùng",
    "Bài đăng chứa nội dung nhạy cảm",
    "Hình ảnh chưa rõ nét",
    "Thông tin bài đăng quá ít"
  ];
  @override
  void initState() {
    super.initState();
    print(Get.arguments);
    _controller.initArg(Get.arguments);
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      barrierColor: const Color.fromARGB(0, 217, 11, 11),
      barrierColor: const Color.fromARGB(0, 217, 11, 11),
      builder: (context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 500.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                  child: Column(children: [
                    // ListView.builder(
                    //   itemCount: 3,
                    //   itemBuilder: (_, i) {
                    //     return Obx(
                    //       () => ListTile(
                    //         title: Text("Hình ảnh chưa rõ nét"),
                    //         trailing: Checkbox(
                    //           onChanged: (value) {},
                    //           value: false,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    Text(
                      "Từ chối đăng tin",
                      style: AppTextStyles.roboto20semiBold
                          .apply(color: AppColors.black),
                    ),
                    const SizedBox.square(
                      dimension: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      child: TextField(
                        controller: messageController,
                        onEditingComplete: () {},
                        minLines: 3,
                        maxLines: 5,
                        onChanged: (value) {},
                        onSubmitted: (value) {},
                        cursorColor: AppColors.backgroundColor,
                        keyboardType: TextInputType.multiline,
                        style: AppTextStyles.roboto16regular
                            .apply(color: AppColors.grey),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(6.h),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Nhập nội dung từ chối",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.gery2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.gery2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.gery2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox.square(
                      dimension: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 35.h,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                color: AppColors.secondary),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  _controller.rejectInfo =
                                      messageController.text;
                                  _controller.rejectPost();
                                  parentController.getRejectedPost();
                                  Get.back();
                                },
                                child: Text(
                                  "Hoàn thành",
                                  style: AppTextStyles.roboto16semiBold
                                      .apply(color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _controller.init(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    _controller.post = snapshot.data?[1];
                    _controller.numOfLikes.value = _controller.post.numOfLikes;
                    _controller.liked.value = snapshot.data?[2];
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
                                        onPressed: _controller.likePost,
                                        icon: (_controller.liked.value)
                                            ? Icon(
                                                Icons.favorite,
                                                color: AppColors.red,
                                              )
                                            : const Icon(
                                                Icons.favorite_border_outlined,
                                              ))),
                                    Obx(() => Text(
                                        _controller.numOfLikes.value.toString(),
                                        style: AppTextStyles.roboto18regular)),
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
                                          CachedNetworkImageProvider(
                                              _controller.userInfo.avatarUrl!),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _controller.userInfo.fullName!,
                                            style:
                                                AppTextStyles.roboto16semiBold,
                                          ),
                                          Text(
                                            (_controller.post.isProSeller)
                                                ? "Môi giới"
                                                : "Cá nhân",
                                            style:
                                                AppTextStyles.roboto14regular,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                        onPressed: _controller.navToUserProfile,
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsets>(
                                                const EdgeInsets.fromLTRB(
                                                    20, 10, 20, 10)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(18.0),
                                                    side: BorderSide(color: AppColors.primaryColor)))),
                                        child: const Text('Xem hồ sơ')),
                                  ],
                                ),
                              ]),
                        ),
                        ExpandableContainer(
                          title: 'Đặc điểm bất động sản',
                          minHeight: 130,
                          child: _controller.postDetail(_controller.post),
                        ),
                        ExpandableContainer(
                          title: 'Mô tả',
                          minHeight: 114,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Text(
                              _controller.post.description,
                              style: AppTextStyles.roboto16regular,
                            ),
                          ),
                        ),
                      ]),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _displayBottomSheet(context);
                    },
                    child: Container(
                      height: 35.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.h),
                          color: AppColors.backgroundColor),
                      child: Center(
                        child: Text(
                          "Từ chối",
                          style: AppTextStyles.roboto16semiBold
                              .apply(color: AppColors.gery2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.square(
                    dimension: 20.h,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 35.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.h),
                          color: AppColors.secondary),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            if (!_controller.isExecute) {
                              _controller.isExecute = true;
                              _controller.approvePost();
                              parentController.getPendingPost();
                              Get.back();
                            }
                          },
                          child: Text(
                            "Duyệt bài",
                            style: AppTextStyles.roboto16semiBold
                                .apply(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  //   bottomNavigationBar: (!_controller.isYourPost)
  //       ? BottomAppBar(
  //           child: SizedBox(
  //           height: 80,
  //           child: Row(children: [
  //             Expanded(
  //                 child: MaterialButton(
  //                     onPressed: _controller.launchPhone,
  //                     color: AppColors.green,
  //                     child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           const Icon(
  //                             Icons.phone_in_talk_outlined,
  //                             size: 24,
  //                             color: Colors.white,
  //                           ),
  //                           Text(
  //                             'Gọi điện',
  //                             style: AppTextStyles.roboto12regular
  //                                 .copyWith(color: Colors.white),
  //                           )
  //                         ]))),
  //             Expanded(
  //                 child: MaterialButton(
  //                     onPressed: _controller.navToChat,
  //                     child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             Assets.messCircle,
  //                             width: 24,
  //                             color: AppColors.green,
  //                           ),
  //                           Text(
  //                             'Chat',
  //                             style: AppTextStyles.roboto12regular
  //                                 .copyWith(color: AppColors.green),
  //                           )
  //                         ]))),
  //             Expanded(
  //                 child: MaterialButton(
  //                     onPressed: _controller.launchSms,
  //                     child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Icon(
  //                             Icons.sms_outlined,
  //                             size: 24,
  //                             color: AppColors.green,
  //                           ),
  //                           Text(
  //                             'Tin nhắn sms',
  //                             style: AppTextStyles.roboto12regular
  //                                 .copyWith(color: AppColors.green),
  //                           )
  //                         ])))
  //           ]),
  //         ))
  //       : null,
  // );
}
