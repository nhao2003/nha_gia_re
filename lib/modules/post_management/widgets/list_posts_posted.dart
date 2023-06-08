import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_management/widgets/item_post.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/enums/enums.dart';
import '../post_management_controller.dart';

class ListPostsPosted extends StatelessWidget {
  ListPostsPosted({super.key});
  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i, Post post) {
    if (i == 0) {
      controller.hidePost(post);
    } else if (i == 1) {
      controller.editPost(post);
    } else if (i == 2) {
      controller.deletePost(post);
    } else if (i == 3) {
      controller.extensionPost(post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.approvedPosts.isEmpty
        ? Center(
            child: Text(
              "Chưa có tin đã đăng",
              style: AppTextStyles.roboto20Bold
                  .copyWith(color: AppColors.primaryColor),
            ),
          )
        : ListView.builder(
            itemCount: controller.approvedPosts.length,
            itemBuilder: (context, index) {
              return ItemPost(
                statusCode: PostStatusMana.approved,
                status:
                    "Hiển thị đến ${controller.approvedPosts[index].expiryDate.toHMDMYString()}",
                post: controller.approvedPosts[index],
                funcs: const [
                  "Ẩn tin",
                  "Chỉnh sửa",
                  "Xóa tin",
                  "Gia hạn",
                ],
                iconFuncs: const [
                  Icons.remove_red_eye_outlined,
                  Icons.edit,
                  Icons.delete_outline,
                  Icons.timer_outlined,
                ],
                onSelectedMenu: onSelectedMenu,
                onTap: controller.navigateToDetailSceen,
              );
            },
          ));
  }
}
