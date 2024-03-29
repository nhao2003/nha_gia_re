import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../my_search_controller.dart';
import 'package:flutter/material.dart';

class CardSortBy extends StatelessWidget {
  final MySearchController searchController;
  const CardSortBy(this.searchController, {super.key});

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
              "Sắp xếp theo",
              style: AppTextStyles.roboto15semiBold
                  .copyWith(color: AppColors.black),
            ),
          ),
          Obx(() => ListTile(
                horizontalTitleGap: 2,
                title: Text(
                  searchController.radioSortType.values[0],
                  style: AppTextStyles.roboto14regular
                      .copyWith(color: AppColors.black),
                ),
                leading: Icon(
                  Icons.schedule,
                  color: AppColors.black,
                ),
                trailing: Radio<int>(
                  value: 0,
                  groupValue:
                      searchController.radioSortType.selectedValue.value,
                  onChanged: (value) {
                    searchController.radioSortType.onChange(value);
                  },
                ),
              )),
          Obx(() => ListTile(
                horizontalTitleGap: 2,
                title: Text(
                  searchController.radioSortType.values[1],
                  style: AppTextStyles.roboto14regular
                      .copyWith(color: AppColors.black),
                ),
                leading: Icon(
                  Icons.sell_outlined,
                  color: AppColors.black,
                ),
                trailing: Radio<int>(
                  value: 1,
                  groupValue:
                      searchController.radioSortType.selectedValue.value,
                  onChanged: (value) {
                    searchController.radioSortType.onChange(value);
                  },
                ),
              )),
        ],
      ),
    );
  }
}
