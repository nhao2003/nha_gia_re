import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.grey,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Danh mục",
            style:
                AppTextStyles.roboto14regular.copyWith(color: AppColors.black),
          ),
          Text(
            "Tat ca",
            style: AppTextStyles.roboto12regular
                .copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
