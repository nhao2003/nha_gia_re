import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/bottom_sheet_radio.dart';

class CategoryBox extends StatelessWidget {
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return BottomSheetRadio();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // show bottomSheet to choose type
        showBottomSheet(context);
      },
      child: Container(
        width: double.infinity,
        height: 58,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.grey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Danh mục",
                  style: AppTextStyles.roboto14regular
                      .copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  "Tat ca",
                  style: AppTextStyles.roboto14regular
                      .copyWith(color: AppColors.primaryColor),
                ),
              ],
            ),
            SizedBox(
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.grey,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
