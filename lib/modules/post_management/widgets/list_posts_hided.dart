import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import '../post_management_controller.dart';
import 'item_post.dart';
import '../../../data/enums/enums.dart';

class ListPostsHided extends StatelessWidget {
  ListPostsHided({super.key});
  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i) {
    if (i == 0) {
      controller.showPost();
    } else if (i == 1) {
      controller.editPost();
    } else if (i == 2) {
      controller.deletePost();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.hidedPosts.isEmpty
        ? Center(
            child: Text(
              "Chưa có tin đã ẩn",
              style: AppTextStyles.roboto20Bold
                  .copyWith(color: AppColors.primaryColor),
            ),
          )
        : ListView.builder(
            itemCount: controller.hidedPosts.length,
            itemBuilder: (context, index) {
              return ItemPost(
                statusCode: PostStatusMana.hided,
                status:
                    "Đã ẩn tin. Hết hạn sau ${controller.hidedPosts[index].expiryDate.toHMDMYString()}",
                post: controller.hidedPosts[index],
                funcs: const [
                  "Hiện tin",
                  "Chỉnh sửa",
                  "Xóa tin",
                ],
                iconFuncs: const [
                  Icons.remove_red_eye_outlined,
                  Icons.edit,
                  Icons.delete_outline,
                ],
                onSelectedMenu: onSelectedMenu,
              );
            },
          ));
    ;
  }
}
