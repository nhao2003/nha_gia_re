import 'package:nha_gia_re/modules/search/widgets/filter_page/category_box_check.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../my_search_controller.dart';
import 'package:flutter/material.dart';

class CardOffice extends StatelessWidget {
  final MySearchController searchController;
  const CardOffice(this.searchController, {super.key});

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
            title: "Loại hình văn phòng",
            categorys: searchController.officeType.checkListItems,
            multipleSelected: searchController.officeType.multipleSelected,
            onChanged: searchController.officeType.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Hướng cửa chính",
            categorys: searchController.officeDirection.checkListItems,
            multipleSelected: searchController.officeDirection.multipleSelected,
            onChanged: searchController.officeDirection.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Giấy tờ pháp lý",
            categorys: searchController.officeLegalDocuments.checkListItems,
            multipleSelected:
                searchController.officeLegalDocuments.multipleSelected,
            onChanged: searchController.officeLegalDocuments.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Tình trạng nội thất",
            categorys: searchController.officeInteriorStatus.checkListItems,
            multipleSelected:
                searchController.officeInteriorStatus.multipleSelected,
            onChanged: searchController.officeInteriorStatus.onChange,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
