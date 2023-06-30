import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../my_search_controller.dart';
import 'package:flutter/material.dart';
import 'category_box_check.dart';

class CardRent extends StatelessWidget {
  final MySearchController searchController;
  const CardRent(this.searchController, {super.key});

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
              "Thông số kĩ thuật",
              style: AppTextStyles.roboto15semiBold
                  .copyWith(color: AppColors.black),
            ),
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Tình trạng nội thất",
            categorys: searchController.rentInteriorStatus.checkListItems,
            multipleSelected:
                searchController.rentInteriorStatus.multipleSelected,
            onChanged: searchController.rentInteriorStatus.onChange,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
