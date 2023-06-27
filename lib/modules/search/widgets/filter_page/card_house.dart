import 'package:nha_gia_re/modules/search/widgets/filter_page/category_box_check.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../search_controller.dart';
import 'package:flutter/material.dart';

class CardHouse extends StatelessWidget {
  final SearchController searchController;
  const CardHouse(this.searchController, {super.key});

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
            title: "Loại hình nhà ở",
            categorys: searchController.houseTypes.checkListItems,
            multipleSelected: searchController.houseTypes.multipleSelected,
            onChanged: searchController.houseTypes.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Đặc điểm nhà/đất",
            categorys: searchController.houseCharacteristics.checkListItems,
            multipleSelected:
                searchController.houseCharacteristics.multipleSelected,
            onChanged: searchController.houseCharacteristics.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Số phòng ngủ",
            categorys: searchController.houseBedroomNumber.checkListItems,
            multipleSelected:
                searchController.houseBedroomNumber.multipleSelected,
            onChanged: searchController.houseBedroomNumber.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Hướng cửa chính",
            categorys: searchController.houseMainDirection.checkListItems,
            multipleSelected:
                searchController.houseMainDirection.multipleSelected,
            onChanged: searchController.houseMainDirection.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Giấy tờ pháp lý",
            categorys: searchController.houseLegalDocuments.checkListItems,
            multipleSelected:
                searchController.houseLegalDocuments.multipleSelected,
            onChanged: searchController.houseLegalDocuments.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Tình trạng nội thất",
            categorys: searchController.houseInteriorStatus.checkListItems,
            multipleSelected:
                searchController.houseInteriorStatus.multipleSelected,
            onChanged: searchController.houseInteriorStatus.onChange,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
