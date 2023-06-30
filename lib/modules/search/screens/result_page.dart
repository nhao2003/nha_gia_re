import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/search/widgets/result_page/dropdownbutton_cities.dart';
import 'package:nha_gia_re/modules/search/widgets/result_page/tab_result.dart';

import '../my_search_controller.dart';

class ResultPage extends StatelessWidget {
  ResultPage({super.key});
  final MySearchController searchController = Get.find<MySearchController>();

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
                    DropdownButtonCities(),
                  ],
                ),
              ),
              // button filter
              OutlinedButton.icon(
                onPressed: () {
                  // filter here
                  searchController.navigateToFilterScreen();
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
        const TabResult(),
      ],
    );
  }
}
