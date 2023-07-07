import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/modules/admin_post_manage/screens/auto_post_form.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';

import '../../../core/theme/text_styles.dart';
import '../../../core/values/assets_image.dart';

class AutoPost extends StatelessWidget {
  const AutoPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          left: 8,
          top: 15,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gery2, width: 1.0)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nội dung thanh toán mặc định",
                  style: AppTextStyles.roboto14regular,
                ),
                const SizedBox.square(
                  dimension: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const AuToFormScreen());
                  },
                  child: const Icon(
                    Icons.edit_note,
                    color: Colors.grey,
                    size: 30,
                  ),
                )
              ],
            ),
            const SizedBox.square(
              dimension: 10,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 4,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                Detail(
                  iconAsset: Assets.ad_type,
                  value: 'Giá property : 50000',
                  icon: Ionicons.calendar_outline,
                ),
                Detail(
                  iconAsset: Assets.ad_type,
                  value: 'Embedddata: trống',
                  icon: Ionicons.receipt_outline,
                ),
                Detail(
                  iconAsset: Assets.ad_type,
                  value: 'Description: Thanh toán tiền cọc',
                  icon: Ionicons.lock_open_outline,
                ),
                Detail(
                  iconAsset: Assets.ad_type,
                  value: 'Mã User:',
                  icon: Ionicons.newspaper_outline,
                ),
              ],
            ),
          ],
        ));
  }
}
