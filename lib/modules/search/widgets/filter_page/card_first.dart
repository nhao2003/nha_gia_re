import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/category_box.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/range_slider_custom.dart';

import '../../search_controller.dart';

class CardFirst extends StatelessWidget {
  final SearchController searchController;
  const CardFirst(this.searchController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CategoryBox(
            title: "Danh mục",
            categorys: searchController.categorys,
            selected: searchController.selectedCategory,
            onChanged: searchController.changeCategory,
          ),
          const SizedBox(height: 20),
          RangeSliderCustom(
            title: 'Giá từ ',
            unit: "đ",
            LOWER: SearchController.LOWER_PRICE,
            UPPER: SearchController.UPPER_PRICE,
            lowerValue: searchController.lowerPriceValue,
            upperValue: searchController.upperPriceValue,
            stepValue: 1000000,
            onChangeValue: searchController.changeValuePrice,
          ),
          RangeSliderCustom(
            title: 'Diện tích ',
            unit: "m2",
            LOWER: SearchController.LOWER_AREA,
            UPPER: SearchController.UPPER_AREA,
            lowerValue: searchController.lowerAreaValue,
            upperValue: searchController.upperAreaValue,
            stepValue: 5,
            onChangeValue: searchController.changeAreaPrice,
          ),
        ],
      ),
    );
  }
}
