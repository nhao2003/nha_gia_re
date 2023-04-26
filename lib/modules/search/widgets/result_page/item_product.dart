import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';

import '../../../../core/values/app_values.dart';

class ItemProduct extends StatelessWidget {
  String urlImage;
  String title;
  int size;
  int money;
  DateTime timeCreated;
  String location;
  bool isFavourited;
  Function onTap;

  ItemProduct({
    super.key,
    required this.urlImage,
    required this.title,
    required this.size,
    required this.money,
    required this.timeCreated,
    required this.location,
    required this.isFavourited,
    required this.onTap,
  });

  double sizeImage = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.white,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              onTap(title);
            },
            child: Row(
              children: [
                // image
                SizedBox(
                  height: sizeImage,
                  width: sizeImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      urlImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/default_image.png",
                          fit: BoxFit.cover,
                        );
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Text(
                        title,
                        style: AppTextStyles.roboto14regular,
                      ),
                      const SizedBox(height: 5),
                      // size
                      Text(
                        "${FormatNum.formatter.format(size)} m2",
                        style: AppTextStyles.roboto12regular
                            .copyWith(color: AppColors.grey),
                      ),
                      const SizedBox(height: 5),
                      // money
                      Text(
                        FormatNum.formatter.format(money),
                        style: AppTextStyles.roboto14semiBold
                            .copyWith(color: AppColors.red),
                      ),
                      const SizedBox(height: 5),
                      // time + location
                      Row(
                        children: [
                          Text(
                            DateFormat(FormatDate.numbericDateFormat)
                                .format(timeCreated),
                            style: AppTextStyles.roboto11regular
                                .copyWith(color: AppColors.grey),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "•",
                            style: AppTextStyles.roboto11regular
                                .copyWith(color: AppColors.grey),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            location,
                            style: AppTextStyles.roboto11regular
                                .copyWith(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // heart
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              child: isFavourited
                  ? Icon(
                      Icons.favorite_sharp,
                      color: AppColors.red,
                    )
                  : const Icon(Icons.favorite_border_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
