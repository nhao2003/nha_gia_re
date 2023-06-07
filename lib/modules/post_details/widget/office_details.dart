import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';

import '../../../core/theme/text_styles.dart';
import '../../../core/values/assets_image.dart';

class OfficeDetails extends StatelessWidget {
  const OfficeDetails({super.key, required this.office});
  final Office office;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 4,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            if (office.isLease)
              Detail(
                iconAsset: Assets.ad_type,
                value: 'Cho Thuê',
              ),
            if(office.deposit != null)
              Detail(iconAsset: Assets.deposit, value: 'Tiền cọc: ${office.deposit?.toFormattedMoney()}'),
            Detail(
              iconAsset: Assets.area,
              value: 'Diện tích: ${office.area} m2',
            ),
            Detail(
              iconAsset: Assets.price_m2,
              value: 'Giá/m2: ${(office.price / office.area).toFormattedMoney()}',
            ),
            if (office.furnitureStatus != null)
              Detail(
                iconAsset: Assets.furnishing_sell,
                value: 'Tình trạng nội thất: ${office.furnitureStatus.toString().tr}',
              ),
            if (office.legalDocumentStatus != null)
              Detail(
                iconAsset: Assets.paper,
                value: 'Giấy tờ pháp lý: ${office.legalDocumentStatus.toString().tr}',
              ),
            if (office.officeType != null)
              Detail(
                iconAsset: Assets.commercial_type,
                value: 'Loại hình văn phòng: ${office.officeType.toString().tr}',
              ),
            if (office.mainDoorDirection != null)
              Detail(
                iconAsset: Assets.direction,
                value: 'Hướng cửa chính: ${office.mainDoorDirection.toString().tr}',
              ),
          ],
        ));
  }
}
