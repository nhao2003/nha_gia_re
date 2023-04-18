import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_first.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_posted_by.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_sort_by.dart';
import '../search_controller.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  final SearchController searchController = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
// appbar
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          "Lọc kết quả",
          style:
              AppTextStyles.roboto18semiBold.copyWith(color: AppColors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: AppColors.black,
          onPressed: () {
            searchController.popScreen();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // deletefilter
              searchController.deleteFilter();
            },
            child: Text(
              "Bỏ lọc",
              style: AppTextStyles.roboto16semiBold
                  .copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
// body
      body: Column(
        children: [
          CardFirst(searchController),
          CardSortBy(searchController),
          CardPostedBy(searchController),
        ],
      ),
    );
  }
}
