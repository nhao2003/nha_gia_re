import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/admin_post_manage/screens/auto_post_form.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';

import '../../../core/theme/text_styles.dart';
import '../../../core/values/assets_image.dart';

class AutoPost extends StatelessWidget {
  const AutoPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
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
                  "Tin sẽ được tự động duyệt nếu thỏa điều kiện",
                  style: AppTextStyles.roboto14regular,
                ),
                SizedBox.square(
                  dimension: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => AuToFormScreen());
                  },
                  child: Icon(
                    Icons.edit_note,
                    color: Colors.grey,
                    size: 30,
                  ),
                )
              ],
            ),
            SizedBox.square(
              dimension: 10,
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 4,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                Detail(
                  iconAsset: Assets.ad_type,
                  value: 'Thời gian tạo tin trễ nhất: 7/2/2023',
                  icon: Ionicons.calendar_outline,
                ),
                Detail(
                  iconAsset: Assets.ad_type,
                  value: 'Số lần chỉnh sửa < 10',
                  icon: Ionicons.receipt_outline,
                ),
                Detail(
                  iconAsset: Assets.ad_type,
                  value: 'Số lần gia hạn < 10',
                  icon: Ionicons.lock_open_outline,
                ),
                Detail(
                  iconAsset: Assets.ad_type,
                  value: 'Số bài đăng tối đa trong tháng < 10',
                  icon: Ionicons.newspaper_outline,
                ),
              ],
            ),
          ],
        ));
  }
}
