import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/admin_post_manage/admin_post_controller.dart';
import 'package:nha_gia_re/modules/admin_post_manage/widgets/auto_post.dart';

class AdminPostScreen extends StatefulWidget {
  const AdminPostScreen({Key? key}) : super(key: key);

  @override
  State<AdminPostScreen> createState() => _AdminPostScreenState();
}

class _AdminPostScreenState extends State<AdminPostScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = Get.find<AdminPostController>();
    controller.getAllPosts();
    tabController = TabController(length: 2, vsync: this);
  }

  late TabController tabController;
  late AdminPostController controller;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Duyệt bài đăng",
          style: AppTextStyles.roboto16regular,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(color: AppColors.white),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  color: AppColors.backgroundColor,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Thanh toán demo",
                          style: AppTextStyles.roboto16semiBold
                              .apply(color: AppColors.grey)
                          // .apply(color: AppColors.black),
                          ),
                      Switch(
                          value: controller.isAutoPost,
                          onChanged: (val) async {
                            setState(() {
                              controller.isAutoPost = val;
                            });
                            // controller.pay();
                          }),
                    ]),
              ),
              SizedBox.square(
                dimension: 10.h,
              ),
              controller.isAutoPost
                  ? const AutoPost()
                  : const SizedBox.shrink(),
              SizedBox.square(
                dimension: 10.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: AppColors.gery2,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        // color: AppColors.backgroundColor,
                        height: height * 0.3,
                        child: Center(
                          child: Text("Chờ duyệt",
                              style: AppTextStyles.roboto16semiBold
                              // .apply(color: AppColors.black),
                              ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        // color: AppColors.backgroundColor,
                        height: height * 0.3,
                        child: Center(
                          child: Text("Đã ẩn",
                              style: AppTextStyles.roboto16semiBold
                              // .apply(color: AppColors.black),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox.square(
                dimension: 10.h,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        color: AppColors.backgroundColor,
                        child: FutureBuilder(
                          future: controller.pendingPosts,
                          builder: (context, snapshot) {
                            var posts = snapshot.data;
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Đã xảy ra lỗi",
                                  style: AppTextStyles.roboto16semiBold
                                      .apply(color: AppColors.primaryColor),
                                ),
                              );
                            } else if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  "Không có tin chờ duyệt mới",
                                  style: AppTextStyles.roboto16semiBold
                                      .apply(color: AppColors.primaryColor),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                padding:
                                    EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
                                itemCount: posts!.length,
                                itemBuilder: (context, index) {
                                  var post = posts[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.navigateToDetailSceen(
                                            posts[index]);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.h),
                                            color: Colors.white60),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 4.w, vertical: 0),
                                          // horizontalTitleGap: 6,
                                          minLeadingWidth: 0,
                                          minVerticalPadding: 0,
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              width: 60,
                                              height: 70,
                                              imageUrl: post.imagesUrl[0],
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  "assets/images/default_image.png",
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                post.title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: AppTextStyles
                                                    .roboto16semiBold,
                                              ),
                                              const SizedBox.square(
                                                dimension: 10,
                                              ),
                                              Text(post.description,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .roboto12regular),
                                            ],
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                controller.formatTime(
                                                    post.postedDate),
                                                style: AppTextStyles
                                                    .roboto12regular,
                                              ),
                                              const Icon(Ionicons
                                                  .arrow_forward_circle_outline),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        color: AppColors.backgroundColor,
                        child: FutureBuilder(
                          future: controller.rejectedPosts,
                          builder: (context, snapshot) {
                            var posts = snapshot.data;
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Đã xảy ra lỗi",
                                  style: AppTextStyles.roboto16semiBold
                                      .apply(color: AppColors.primaryColor),
                                ),
                              );
                            } else if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  "Không có tin chờ duyệt mới",
                                  style: AppTextStyles.roboto16semiBold
                                      .apply(color: AppColors.primaryColor),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                padding:
                                    EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                                itemCount: posts!.length,
                                itemBuilder: (context, index) {
                                  var post = posts[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.navigateToDetailSceen(
                                            posts[index]);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.h),
                                            color: Colors.white60),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 4.w, vertical: 0),
                                          // horizontalTitleGap: 6,
                                          minLeadingWidth: 0,
                                          minVerticalPadding: 0,
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              width: 60,
                                              height: 70,
                                              imageUrl: post.imagesUrl[0],
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  "assets/images/default_image.png",
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                post.title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: AppTextStyles
                                                    .roboto16semiBold,
                                              ),
                                              const SizedBox.square(
                                                dimension: 10,
                                              ),
                                              Text(post.description,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .roboto12regular),
                                            ],
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                controller.formatTime(
                                                    post.postedDate),
                                                style: AppTextStyles
                                                    .roboto12regular,
                                              ),
                                              const Icon(Ionicons
                                                  .arrow_forward_circle_outline),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox.square(
                dimension: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
