import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';

import '../../../../core/values/app_values.dart';

class ItemProduct extends StatefulWidget {
  Post post;
  bool isFavourited;
  Function onTap;

  ItemProduct({
    super.key,
    required this.post,
    required this.isFavourited,
    required this.onTap,
  });

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  double sizeImage = 100;

  void toggleFav() {
    setState(() {
      widget.isFavourited = !widget.isFavourited;
    });
  }

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
              widget.onTap(widget.post);
            },
            child: Row(
              children: [
                // image
                SizedBox(
                  height: sizeImage,
                  width: sizeImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: widget.post.imagesUrl[0],
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/default_image.png",
                          fit: BoxFit.cover,
                        );
                      },
                      progressIndicatorBuilder: (ctx, str, prc){
                        return Center(
                          child: CircularProgressIndicator(
                            value: prc.progress,
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
                        widget.post.title,
                        style: AppTextStyles.roboto14regular,
                      ),
                      const SizedBox(height: 5),
                      // size
                      Text(
                        "${FormatNum.formatter.format(widget.post.area.toInt())} m2",
                        style: AppTextStyles.roboto12regular
                            .copyWith(color: AppColors.grey),
                      ),
                      const SizedBox(height: 5),
                      // money
                      Text(
                        FormatNum.formatter.format(widget.post.price.toInt()),
                        style: AppTextStyles.roboto14semiBold
                            .copyWith(color: AppColors.red),
                      ),
                      const SizedBox(height: 5),
                      // time + location
                      Row(
                        children: [
                          Text(
                            DateFormat(FormatDate.numbericDateFormat)
                                .format(widget.post.postedDate),
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
                            widget.post.address.cityName.toString(),
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
            child: GestureDetector(
              onTap: () {
                toggleFav();
              },
              child: SizedBox(
                child: widget.isFavourited
                    ? Icon(
                        Icons.favorite_sharp,
                        color: AppColors.red,
                      )
                    : const Icon(Icons.favorite_border_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
