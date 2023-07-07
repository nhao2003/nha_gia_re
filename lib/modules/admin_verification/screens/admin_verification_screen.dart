import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/admin_verification/admin_verification_controller.dart';
import 'package:nha_gia_re/modules/admin_verification/widgets/user_item.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class AdminVerificationScreen extends StatelessWidget {
  AdminVerificationScreen({super.key});
  AdminVerificationController controller =
      Get.find<AdminVerificationController>();
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
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
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
                            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
                            itemCount: requests!.length,
                            itemBuilder: (context, index) {
                              var res = requests[index];
                              return UserItem(res);
                            },
                          );
                        }
                      },
                    ),
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
