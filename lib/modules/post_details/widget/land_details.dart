import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';
import '../../../core/values/assets_image.dart';

class LandDetails extends StatelessWidget {
  const LandDetails({Key? key, required this.land}) : super(key: key);

  final Land land;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 4,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: [
          if (land.isLease)
            Detail(
              iconAsset: Assets.ad_type,
              value: 'For Lease'.tr,
            ),
          if (land.deposit != null)
            Detail(
              iconAsset: Assets.deposit,
              value: '${'Deposit:'.tr} ${land.deposit?.toFormattedMoney()}',
            ),
          Detail(
            iconAsset: Assets.area,
            value: '${'Area:'.tr} ${land.area} m2',
          ),
          Detail(
            iconAsset: Assets.price_m2,
            value: '${'Price/m2:'.tr} ${(land.price / land.area).toFormattedMoney()}',
          ),
          if (land.width != null)
            Detail(
              iconAsset: Assets.width,
              value: '${'Width:'.tr} ${land.width}',
            ),
          if (land.length != null)
            Detail(
              iconAsset: Assets.length,
              value: '${'Length:'.tr} ${land.length}',
            ),
          if (land.legalDocumentStatus != null)
            Detail(
              iconAsset: Assets.paper,
              value: '${'Legal Document:'.tr} ${land.legalDocumentStatus.toString().tr}',
            ),
          if (land.landType != null)
            Detail(
              iconAsset: Assets.land_type,
              value: '${'Land Type:'.tr} ${land.landType.toString().tr}',
            ),
          if (land.landDirection != null)
            Detail(
              iconAsset: Assets.direction,
              value: '${'Main Door Direction:'.tr} ${land.landDirection.toString().tr}',
            ),
        ],
      ),
    );
  }
}
