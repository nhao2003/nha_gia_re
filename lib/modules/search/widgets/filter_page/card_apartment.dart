import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../search_controller.dart';
import 'package:flutter/material.dart';
import 'category_box.dart';

class CardApartment extends StatelessWidget {
  final SearchController searchController;
  const CardApartment(this.searchController, {super.key});

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
          CategoryBox(
            title: "Tình trạng",
            categorys: searchController.apartmentStatus.values,
            selected: searchController.apartmentStatus.selectedValue,
            onChanged: searchController.apartmentStatus.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBox(
            title: "Loại hình căn hộ",
            categorys: searchController.apartmentTypes.values,
            selected: searchController.apartmentTypes.selectedValue,
            onChanged: searchController.apartmentTypes.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBox(
            title: "Đặc điểm căn hộ",
            categorys: searchController.apartmentCharacteristics.values,
            selected: searchController.apartmentCharacteristics.selectedValue,
            onChanged: searchController.apartmentCharacteristics.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBox(
            title: "Số phòng ngủ",
            categorys: searchController.apartmentBedroomNumber.values,
            selected: searchController.apartmentBedroomNumber.selectedValue,
            onChanged: searchController.apartmentBedroomNumber.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBox(
            title: "Hướng cửa chính",
            categorys: searchController.apartmentMainDirection.values,
            selected: searchController.apartmentMainDirection.selectedValue,
            onChanged: searchController.apartmentMainDirection.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBox(
            title: "Hướng ban công",
            categorys: searchController.apartmentBalconyDirection.values,
            selected: searchController.apartmentBalconyDirection.selectedValue,
            onChanged: searchController.apartmentBalconyDirection.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBox(
            title: "Giấy tờ pháp lý",
            categorys: searchController.apartmentLegalDocuments.values,
            selected: searchController.apartmentLegalDocuments.selectedValue,
            onChanged: searchController.apartmentLegalDocuments.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBox(
            title: "Tình trạng nội thất",
            categorys: searchController.apartmentInteriorStatus.values,
            selected: searchController.apartmentInteriorStatus.selectedValue,
            onChanged: searchController.apartmentInteriorStatus.onChange,
          ),
        ],
      ),
    );
  }
}
