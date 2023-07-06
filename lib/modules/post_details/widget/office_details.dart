import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';
import '../../../core/values/assets_image.dart';

class OfficeDetails extends StatelessWidget {
  const OfficeDetails({Key? key, required this.office}) : super(key: key);

  final Office office;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 4,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: [
          if (office.isLease)
            Detail(
              iconAsset: Assets.ad_type,
              value: 'For Lease'.tr,
            ),
          if(office.deposit != null)
            Detail(
              iconAsset: Assets.deposit,
              value: '${'Deposit:'.tr} ${office.deposit?.toFormattedMoney()}',
            ),
          Detail(
            iconAsset: Assets.area,
            value: '${'Area:'.tr} ${office.area} m2',
          ),
          Detail(
            iconAsset: Assets.price_m2,
            value: '${'Price/m2:'.tr} ${(office.price / office.area).toFormattedMoney()}',
          ),
          if (office.furnitureStatus != null)
            Detail(
              iconAsset: Assets.furnishing_sell,
              value: '${'Furniture Status:'.tr} ${office.furnitureStatus.toString().tr}',
            ),
          if (office.legalDocumentStatus != null)
            Detail(
              iconAsset: Assets.paper,
              value: '${'Legal Document:'.tr} ${office.legalDocumentStatus.toString().tr}',
            ),
          if (office.officeType != null)
            Detail(
              iconAsset: Assets.commercial_type,
              value: '${'Office Type:'.tr} ${office.officeType.toString().tr}',
            ),
          if (office.mainDoorDirection != null)
            Detail(
              iconAsset: Assets.direction,
              value: '${'Main Door Direction:'.tr} ${office.mainDoorDirection.toString().tr}',
            ),
        ],
      ),
    );
  }
}
