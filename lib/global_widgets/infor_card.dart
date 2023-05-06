import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/app_values.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/modules/home/screens/post_details_screen.dart';

import '../data/models/properties/post.dart';

class InforCardProps {
  String title;
  String price;
  String address;
  DateTime postTime;
  String imageUrl;

  InforCardProps(
      {required this.title,
      required this.price,
      required this.address,
      required this.postTime,
      required this.imageUrl});
}

class InforCard extends StatelessWidget {
  InforCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.secondary,
      child: SizedBox(
        width: 180,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.network(
              post.imagesUrl.first,
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
            post.price.toString(),
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
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            post.postedDate.getTimeAgo(),
            style:
                AppTextStyles.roboto12semiBold.copyWith(color: AppColors.grey),
          )
        ]),
      ),
    );
  }
}

class InforCardList extends StatefulWidget {
  const InforCardList({super.key, required this.title, required this.list});

  final String title;
  final List<Post> list;

  @override
  State<InforCardList> createState() => _InforCardListState();
}

// InforCardProps props = InforCardProps(
//     title: 'Testing testing',
//     address: '131/2 tay son quy nhon',
//     price: '1.6000.000/căn',
//     postTime: DateTime(2023, 3, 23, 15, 36),
//     imageUrl: 'https://picsum.photos/110/180?random=');

class _InforCardListState extends State<InforCardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.title,
          style: AppTextStyles.roboto20Bold,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 210,
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
                  child: InforCard(key: UniqueKey(), post: widget.list[index]),
                  onTap: () {
                    //TODO: Handle detail screen
                    //Get.to(PostDetailsScreen(title: props.title));
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
            InkWell(
              child: Text(
                'Xem thêm 12.345 mẫu tin khác',
                style: AppTextStyles.roboto16regular
                    .copyWith(color: AppColors.blue),
              ),
              onTap: () {},
            ),
          ],
        )
      ]),
    );
  }
}
