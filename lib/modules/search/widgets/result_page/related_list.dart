import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/models/post.dart';
import 'package:nha_gia_re/data/models/product.dart';
import 'package:nha_gia_re/data/providers/data_center.dart';
import 'package:nha_gia_re/modules/search/widgets/result_page/item_product.dart';
import '../../../../core/theme/app_colors.dart';

class RelatedList extends StatelessWidget {
  const RelatedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: ListView.builder(
        itemCount: DataCenter.instance.dummyPosts.length,
        itemBuilder: (_, i) {
          Post prod = DataCenter.instance.dummyPosts[i];
          return ItemProduct(
            urlImage: prod.imagesUrl[0],
            title: prod.title,
            money: prod.price.toString(),
            size: "100m2",
            location: "Long An",
            timeCreated: prod.postedAt,
            isFavourited: false,
          );
        },
      ),
    );
  }
}
