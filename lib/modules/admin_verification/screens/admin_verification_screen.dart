import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/admin_verification/admin_verification_controller.dart';
import 'package:nha_gia_re/modules/admin_verification/widgets/user_item.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class AdminVerificationScreen extends StatefulWidget {
  const AdminVerificationScreen({super.key});

  @override
  State<AdminVerificationScreen> createState() =>
      _AdminVerificationScreenState();
}

class _AdminVerificationScreenState extends State<AdminVerificationScreen>
    with TickerProviderStateMixin {
  AdminVerificationController controller =
      Get.find<AdminVerificationController>();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  late TabController tabController;

  void updateList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Định danh tài khoản",
          style: AppTextStyles.roboto16regular,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(color: AppColors.white),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Danh sách các tài khoản",
                style: AppTextStyles.roboto18Bold,
              ),
              const SizedBox(height: 20),
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
                        height: 100,
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
                        height: 100,
                        child: Center(
                          child: Text("Đã duyệt",
                              style: AppTextStyles.roboto16semiBold
                              // .apply(color: AppColors.black),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Container(
                        color: AppColors.backgroundColor,
                        child: FutureBuilder(
                          future: controller.getListRequest(),
                          builder: (context, snapshot) {
                            var requests = snapshot.data;
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
                                  "Không có tài khoản chờ duyệt mới",
                                  style: AppTextStyles.roboto16semiBold
                                      .apply(color: AppColors.primaryColor),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                padding:
                                    EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
                                itemCount: requests!.length,
                                itemBuilder: (context, index) {
                                  var res = requests[index];
                                  return UserItem(res, updateList);
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        color: AppColors.backgroundColor,
                        child: FutureBuilder(
                          future: controller.getListVerifieds(),
                          builder: (context, snapshot) {
                            var requests = snapshot.data;
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
                                  "Không có tài khoản chờ duyệt mới",
                                  style: AppTextStyles.roboto16semiBold
                                      .apply(color: AppColors.primaryColor),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                padding:
                                    EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
                                itemCount: requests!.length,
                                itemBuilder: (context, index) {
                                  var res = requests[index];
                                  return UserItem(res, updateList);
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
