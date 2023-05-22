import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';

import '../../../core/theme/text_styles.dart';
import '../../../core/values/assets_image.dart';

class ApartmentDetails extends StatelessWidget {
  const ApartmentDetails({super.key, required this.apartment});
  final Apartment apartment;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 3,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            if (apartment.isLease)
              Detail(
                iconAsset: Assets.ad_type,
                value: 'Cho Thuê',
              ),
            if (apartment.furnitureStatus != null)
              Detail(
                iconAsset: Assets.furnishing_sell,
                value: 'Tình trạng nội thất: ${apartment.furnitureStatus}',
              ),
            Detail(
              iconAsset: Assets.area,
              value: 'Diện tích: ${apartment.area} m2',
            ),
            Detail(
              iconAsset: Assets.price_m2,
              value: 'Giá/m2: ${apartment.price / apartment.area} triệu/m2',
            ),
            if (apartment.block != null)
              Detail(
                iconAsset: Assets.block,
                value: 'Tên phân khu: ${apartment.block}',
              ),
            if (apartment.numOfBedRooms != null)
              Detail(
                iconAsset: Assets.room_num,
                value: 'Số phòng ngủ: ${apartment.numOfBedRooms} phòng',
              ),
            if (apartment.numOfToilets != null)
              Detail(
                iconAsset: Assets.toilets,
                value: 'Số phòng vệ sinh: ${apartment.numOfToilets} phòng',
              ),
            if (apartment.legalDocumentStatus != null)
              Detail(
                iconAsset: Assets.paper,
                value: 'Giấy tờ pháp lý: ${apartment.legalDocumentStatus}',
              ),
            if (apartment.apartmentType != null)
              Detail(
                iconAsset: Assets.commercial_type,
                value: 'Loại hình căn hộ: ${apartment.apartmentType}',
              ),
            if (apartment.floor != null)
              Detail(
                iconAsset: Assets.floornumber,
                value: 'Tầng số: ${apartment.floor}',
              ),
            if (apartment.mainDoorDirection != null)
              Detail(
                iconAsset: Assets.direction,
                value: 'Hướng cửa chính: ${apartment.mainDoorDirection}',
              ),
            if (apartment.balconyDirection != null)
              Detail(
                iconAsset: Assets.balconyDirection,
                value: 'Hướng ban công: ${apartment.balconyDirection}',
              ),
          ],
        ));
  }
}
