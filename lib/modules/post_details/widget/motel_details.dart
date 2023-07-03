import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';
import '../../../core/values/assets_image.dart';

class MotelDetails extends StatelessWidget {
  const MotelDetails({super.key, required this.motel});
  final Motel motel;

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
            if (motel.isLease)
              Detail(
                iconAsset: Assets.ad_type,
                value: 'Cho Thuê',
              ),
            if(motel.deposit != null)
              Detail(iconAsset: Assets.deposit, value: 'Tiền cọc: ${motel.deposit?.toFormattedMoney()}'),
            Detail(
              iconAsset: Assets.area,
              value: 'Diện tích: ${motel.area} m2',
            ),
            if (motel.waterPrice != null)
              Detail(
                iconAsset: Assets.water,
                value: 'Giá nước: ${motel.waterPrice?.toFormattedMoney()}/khối',
              ),
              if (motel.electricPrice != null)
              Detail(
                iconAsset: Assets.electric,
                value: 'Giá điện: ${motel.electricPrice?.toFormattedMoney()}/KWh',
              ),
            if (motel.furnitureStatus != null)
              Detail(
                iconAsset: Assets.furnishing_sell,
                value: 'Tình trạng nội thất: ${motel.furnitureStatus.toString().tr}',
              ),
          ],
        ));
  }
}
