import 'package:flutter/material.dart';
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
        itemCount: DataCenter.instance.products.length,
        itemBuilder: (_, i) {
          Product prod = DataCenter.instance.products[i];
          return ItemProduct(
            urlImage: prod.urlImage!,
            title: prod.title,
            money: prod.money,
            size: prod.size,
            location: prod.location,
            timeCreated: prod.timeCreated!,
            isFavourited: prod.isFavourited!,
          );
        },
      ),
    );
  }
}
