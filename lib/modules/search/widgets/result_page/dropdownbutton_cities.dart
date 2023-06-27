import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/values/filter_values.dart';
import '../../search_controller.dart';

class DropdownButtonCities extends StatelessWidget {
  DropdownButtonCities({super.key});
  final SearchController searchController = Get.find<SearchController>();

  /// data in fill city
  final List<DropdownMenuItem<String>> dropDownMenuItems =
      FilterValues.instance.provinces
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: AppTextStyles.roboto14regular
                      .copyWith(color: AppColors.black)),
            ),
          )
          .toList();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          value: searchController.selectedTypeItem.value,
          style: AppTextStyles.roboto14regular.copyWith(color: AppColors.black),
          onChanged: (String? newValue) {
            if (newValue != null) {
              searchController.changeSelectedItem(newValue);
            }
          },
          items: dropDownMenuItems,
          buttonStyleData: const ButtonStyleData(
            height: 40,
            width: 140,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 400,
          ),
        ),
      ),
    );
  }
}
