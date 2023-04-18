import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/search/widgets/filter_page/bottom_sheet_radio.dart';

class CategoryBox extends StatelessWidget {
  String title;
  List<String> categorys;
  RxInt selected;
  Function onChanged;

  CategoryBox({
    required this.title,
    required this.categorys,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return BottomSheetRadio(
          categorys: [...categorys],
          onChanged: onChanged,
          selected: selected,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // show bottomSheet to choose type
        showBottomSheet(context);
      },
      child: Container(
        width: double.infinity,
        height: 58,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.grey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.roboto14regular
                      .copyWith(color: AppColors.black),
                ),
                const SizedBox(height: 5),
                Obx(
                  () => Text(
                    categorys[selected.value],
                    style: AppTextStyles.roboto14regular
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.grey,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
