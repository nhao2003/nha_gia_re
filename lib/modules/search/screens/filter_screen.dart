import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_apartment.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_first.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_house.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_land.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_office.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_posted_by.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/card_rent.dart';
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
            searchController.deleteFilter();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // deletefilter
              searchController.deleteFilter();
            },
            child: Text(
              "Đặt lại",
              style: AppTextStyles.roboto16semiBold
                  .copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
// body
      body: Column(
        children: [
          SizedBox(
            height: 83.hp,
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: [
                    // cards
                    CardFirst(searchController),
                    if (searchController.radioCategory.selectedValue.value == 1)
                      CardApartment(searchController),
                    if (searchController.radioCategory.selectedValue.value == 2)
                      CardHouse(searchController),
                    if (searchController.radioCategory.selectedValue.value == 3)
                      CardLand(searchController),
                    if (searchController.radioCategory.selectedValue.value == 4)
                      CardOffice(searchController),
                    if (searchController.radioCategory.selectedValue.value == 5)
                      CardRent(searchController),
                    CardSortBy(searchController),
                    CardPostedBy(searchController),
                  ],
                ),
              ),
            ),
          ),
// apply button
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Material(
                color: AppColors.primaryColor,
                child: InkWell(
                  onTap: () async {
                    // Apply filter
                    //print("hafkjsfhasldfhak;asdasd");
                    await searchController.applyFilter();
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "ÁP DỤNG",
                        style: AppTextStyles.roboto15regular
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
