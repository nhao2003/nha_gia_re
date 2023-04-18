import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/providers/data_center.dart';
import 'package:nha_gia_re/modules/search/widgets/result_page/item_product.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/properties/post.dart';

class RelatedList extends StatelessWidget {
  const RelatedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: ListView.builder(
        itemCount: DataCenter.instance.listPosts.length,
        itemBuilder: (_, i) {
          Post prod = DataCenter.instance.listPosts[i];
          return ItemProduct(
            urlImage: prod.imagesUrl[0],
            title: prod.title,
            money: prod.price.toInt(),
            size: prod.area.toInt(),
            location: "Long An",
            timeCreated: prod.postedDate,
            isFavourited: false,
          );
        },
      ),
    );
  }
}
