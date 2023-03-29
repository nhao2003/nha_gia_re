import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';

import '../../search_controller.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});

  final SearchController searchController = Get.find<SearchController>();

  /// data in fill city
  final List<DropdownMenuItem<String>> dropDownMenuItems =
      SearchController.provinces
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
    return Column(
      children: [
        // khu vuc toan quoc + loc
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // khu vuc toan quoc
              SizedBox(
                child: Row(
                  children: [
                    // icon + khu vuc toan quoc
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 5),
                    Text(
                      "Khu Vực",
                      style: AppTextStyles.roboto14regular
                          .copyWith(color: AppColors.black),
                    ),
                    const SizedBox(width: 5),
                    // dropdown button
                    Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          value: searchController.selectedTypeItem.value,
                          style: AppTextStyles.roboto14regular
                              .copyWith(color: AppColors.black),
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
                    ),
                  ],
                ),
              ),
              // button filter
              OutlinedButton.icon(
                onPressed: () {
                  // filter here
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                ),
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: AppColors.black,
                ),
                label: Text(
                  "Lọc",
                  style: AppTextStyles.roboto12regular.copyWith(
                    color: AppColors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        // tab : Lien quan - tin moi nhat
        DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                indicatorColor: AppColors.primaryColor,
                tabs: const [
                  Tab(
                    text: "Liên quan",
                  ),
                  Tab(
                    text: "Tin mới nhất",
                  ),
                ],
              ),
            ],
          ),
        ),
        // listView
      ],
    );
  }
}
