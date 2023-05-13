import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/enums/enums.dart';
import '../../../data/models/properties/post.dart';
import '../post_management_controller.dart';
import 'item_post.dart';

class ListPostsReject extends StatelessWidget {
  ListPostsReject({super.key});

  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i) {
    if (i == 0) {
      controller.deletePost();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.rejectedPosts.isEmpty
        ? Center(
            child: Text(
              "Chưa có tin bị từ chối",
              style: AppTextStyles.roboto20Bold
                  .copyWith(color: AppColors.primaryColor),
            ),
          )
        : ListView.builder(
            itemCount: controller.rejectedPosts.length,
            itemBuilder: (context, i) {
              return ItemPost(
                statusCode: PostStatusMana.rejected,
                status: controller.rejectedPosts[i].rejectedInfo!,
                post: controller.rejectedPosts[i],
                funcs: const [
                  "Xóa tin",
                ],
                iconFuncs: const [
                  Icons.delete_outline,
                ],
                onSelectedMenu: onSelectedMenu,
                onTap: (Post post) {},
              );
            },
          ));
    ;
  }
}
