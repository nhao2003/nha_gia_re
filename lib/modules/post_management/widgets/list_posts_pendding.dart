import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/enums/enums.dart';
import '../../../data/models/properties/post.dart';
import '../post_management_controller.dart';
import 'item_post.dart';

class ListPostsPendding extends StatelessWidget {
  ListPostsPendding({super.key});
  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i, Post post) {
    if (i == 0) {
      controller.editPost(post);
    } else if (i == 1) {
      controller.deletePost(post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.pendingPosts.isEmpty
        ? Center(
            child: Text(
              "Chưa có tin đang chờ duyệt",
              style: AppTextStyles.roboto20Bold
                  .copyWith(color: AppColors.primaryColor),
            ),
          )
        : ListView.builder(
            itemCount: controller.pendingPosts.length,
            itemBuilder: (context, index) {
              return ItemPost(
                statusCode: PostStatusMana.pending,
                status: "Đang chờ duyệt",
                post: controller.pendingPosts[index],
                funcs: const [
                  "Chỉnh sửa",
                  "Xóa tin",
                ],
                iconFuncs: const [
                  Icons.edit,
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
