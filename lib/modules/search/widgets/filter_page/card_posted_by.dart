import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../search_controller.dart';
import 'package:flutter/material.dart';

class CardPostedBy extends StatelessWidget {
  final SearchController searchController;
  const CardPostedBy(this.searchController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: double.infinity,
      color: AppColors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 16,
            ),
            child: Text(
              "Đăng bởi",
              style: AppTextStyles.roboto15semiBold
                  .copyWith(color: AppColors.black),
            ),
          ),
          Obx(() => ListTile(
                horizontalTitleGap: 2,
                title: Text(
                  searchController.radiopostedBy.values[0],
                  style: AppTextStyles.roboto14regular
                      .copyWith(color: AppColors.black),
                ),
                leading: Icon(
                  Icons.person_outline,
                  color: AppColors.black,
                ),
                trailing: Radio<int>(
                  value: 0,
                  groupValue:
                      searchController.radiopostedBy.selectedValue.value,
                  onChanged: (value) {
                    searchController.radiopostedBy.onChange(value);
                  },
                ),
              )),
          Obx(() => ListTile(
                horizontalTitleGap: 2,
                title: Text(
                  searchController.radiopostedBy.values[1],
                  style: AppTextStyles.roboto14regular
                      .copyWith(color: AppColors.black),
                ),
                leading: Icon(
                  Icons.business_center_outlined,
                  color: AppColors.black,
                ),
                trailing: Radio<int>(
                  value: 1,
                  groupValue:
                      searchController.radiopostedBy.selectedValue.value,
                  onChanged: (value) {
                    searchController.radiopostedBy.onChange(value);
                  },
                ),
              )),
        ],
      ),
    );
  }
}
