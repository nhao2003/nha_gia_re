import 'package:nha_gia_re/modules/search/widgets/filter_page/category_box_check.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../my_search_controller.dart';
import 'package:flutter/material.dart';

class CardLand extends StatelessWidget {
  final MySearchController searchController;
  const CardLand(this.searchController, {super.key});

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
            title: "Loại hình đất",
            categorys: searchController.landTypes.checkListItems,
            multipleSelected: searchController.landTypes.multipleSelected,
            onChanged: searchController.landTypes.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Đặc điểm nhà/đất",
            categorys: searchController.landCharacteristics.checkListItems,
            multipleSelected:
                searchController.landCharacteristics.multipleSelected,
            onChanged: searchController.landCharacteristics.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Hướng đất",
            categorys: searchController.landDirection.checkListItems,
            multipleSelected: searchController.landDirection.multipleSelected,
            onChanged: searchController.landDirection.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Giấy tờ pháp lý",
            categorys: searchController.landLegalDocuments.checkListItems,
            multipleSelected:
                searchController.landLegalDocuments.multipleSelected,
            onChanged: searchController.landLegalDocuments.onChange,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
