import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../post_management_controller.dart';
import 'item_post.dart';
import '../../../data/enums/enums.dart';

class ListPostsExpried extends StatelessWidget {
  ListPostsExpried({super.key});
  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i) {
    if (i == 0) {
      controller.deletePost();
    } else if (i == 1) {
      controller.extensionPost();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.expiredPosts.isEmpty
        ? Center(
            child: Text(
              "Chưa có tin hết hạn",
              style: AppTextStyles.roboto20Bold
                  .copyWith(color: AppColors.primaryColor),
            ),
          )
        : ListView.builder(
            itemCount: controller.expiredPosts.length,
            itemBuilder: (context, index) {
              return ItemPost(
                statusCode: PostStatusMana.expired,
                status: "Hiển thị đến 12:23 9/9/2023",
                post: controller.expiredPosts[index],
                funcs: const [
                  "Xóa tin",
                  "Gia hạn",
                ],
                iconFuncs: const [
                  Icons.delete_outline,
                  Icons.timer_outlined,
                ],
                onSelectedMenu: onSelectedMenu,
              );
            },
          ));
  }
}
