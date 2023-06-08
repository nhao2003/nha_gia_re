import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';

import '../../../core/theme/text_styles.dart';
import '../../../core/values/assets_image.dart';

class LandDetails extends StatelessWidget {
  const LandDetails({super.key, required this.land});
  final Land land;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 4,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            if (land.isLease)
              Detail(
                iconAsset: Assets.ad_type,
                value: 'Cho Thuê',
              ),
            if(land.deposit != null)
              Detail(iconAsset: Assets.deposit, value: 'Tiền cọc: ${land.deposit?.toFormattedMoney()}'),
            Detail(
              iconAsset: Assets.area,
              value: 'Diện tích: ${land.area} m2',
            ),
            Detail(
              iconAsset: Assets.price_m2,
              value: 'Giá/m2: ${(land.price / land.area).toFormattedMoney()}',
            ),
            if (land.width != null)
              Detail(
                iconAsset: Assets.width,
                value: 'Chiều ngang: ${land.width}',
              ),
              if (land.length != null)
              Detail(
                iconAsset: Assets.length,
                value: 'Chiều dài: ${land.length}',
              ),
            if (land.legalDocumentStatus != null)
              Detail(
                iconAsset: Assets.paper,
                value: 'Giấy tờ pháp lý: ${land.legalDocumentStatus.toString().tr}',
              ),
            if (land.landType != null)
              Detail(
                iconAsset: Assets.land_type,
                value: 'Loại hình đất: ${land.landType.toString().tr}',
              ),
            if (land.landDirection != null)
              Detail(
                iconAsset: Assets.direction,
                value: 'Hướng cửa chính: ${land.landDirection.toString().tr}',
              ),
          ],
        ));
  }
}
