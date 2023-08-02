import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/core/extensions/string_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../core/values/filter_values.dart';
import '../data/models/properties/post.dart';

class InforCard extends StatelessWidget {
  const InforCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: InkWell(
        splashColor: AppColors.secondary,
        child: Container(
          color: AppColors.white,
          width: 180,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: post.imagesUrl.first,
                fit: BoxFit.fill,
                height: 110,
                width: 180,
              ),
            ),
            Text(
              post.title,
              style: AppTextStyles.roboto16semiBold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              post.price.toFormattedMoney(isLease: post.isLease),
              style:
                  AppTextStyles.roboto16semiBold.copyWith(color: AppColors.red),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              post.address.toString(),
              style: AppTextStyles.roboto12semiBold.copyWith(
                  color: AppColors.grey, overflow: TextOverflow.ellipsis),
              maxLines: 1,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              maxLines: 1,
              post.postedDate.getTimeAgo(),
              style: AppTextStyles.roboto12semiBold
                  .copyWith(color: AppColors.grey),
            )
          ]),
        ),
      ),
    );
  }
}

class InforCardList extends StatefulWidget {
  const InforCardList(
      {super.key,
      required this.title,
      required this.list,
      required this.navType,
      this.province,
      this.uid});

  final String title;
  final List<Post> list;
  final TypeNavigate navType;
  final String? province;
  final String? uid;

  @override
  State<InforCardList> createState() => _InforCardListState();
}

class _InforCardListState extends State<InforCardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 350),
      padding: const EdgeInsets.all(10),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppTextStyles.roboto20Bold,
          ),
          const SizedBox(
            height: 10,
          ),
          if (widget.list.isNotEmpty)
            Flexible(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.list.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        width: 10,
                      ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child:
                          InforCard(key: UniqueKey(), post: widget.list[index]),
                      onTap: () {
                        Get.toNamed(
                            AppRoutes.getPostRoute(widget.list[index].id),
                            arguments: widget.list[index]);
                      },
                    );
                  }),
            ),
          const Divider(
            thickness: 0.5,
            height: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomTapAnimation(
                child: InkWell(
                  child: Text(
                    'See more'.tr,
                    style: AppTextStyles.roboto16regular
                        .copyWith(color: AppColors.blue),
                  ),
                  onTap: () {
                    String? matchingProvince;
                    if (widget.province != null) {
                      matchingProvince =
                          FilterValues.instance.provinces.firstWhere(
                        (item) => widget.province!
                            .noAccentVietnamese()
                            .contains(item.noAccentVietnamese()),
                      );
                    }
                    var data = {
                      "title": widget.title,
                      "type": widget.navType,
                      "province": matchingProvince,
                      "uid": widget.uid,
                    };
                    Get.toNamed(AppRoutes.resultArg, arguments: data);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
