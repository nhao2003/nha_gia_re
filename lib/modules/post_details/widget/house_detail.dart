import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';

import '../../../core/theme/text_styles.dart';
import '../../../core/values/assets_image.dart';

class HouseDetails extends StatelessWidget {
  const HouseDetails({super.key, required this.house});
  final House house;

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
            if (house.isLease)
              Detail(
                iconAsset: Assets.ad_type,
                value: 'Cho Thuê',
              ),
            Detail(
              iconAsset: Assets.area,
              value: 'Diện tích: ${house.area} m2',
            ),
            Detail(
              iconAsset: Assets.price_m2,
              value: 'Giá/m2: ${house.price / house.area} triệu/m2',
            ),
            if (house.width != null)
              Detail(
                iconAsset: Assets.width,
                value: 'Chiều ngang: ${house.width}',
              ),
              if (house.length != null)
              Detail(
                iconAsset: Assets.length,
                value: 'Chiều dài: ${house.length}',
              ),
            if (house.furnitureStatus != null)
              Detail(
                iconAsset: Assets.furnishing_sell,
                value: 'Tình trạng nội thất: ${house.furnitureStatus}',
              ),
            if (house.numOfBedRooms != null)
              Detail(
                iconAsset: Assets.room_num,
                value: 'Số phòng ngủ: ${house.numOfBedRooms} phòng',
              ),
            if (house.numOfToilets != null)
              Detail(
                iconAsset: Assets.toilets,
                value: 'Số phòng vệ sinh: ${house.numOfToilets} phòng',
              ),
            if (house.legalDocumentStatus != null)
              Detail(
                iconAsset: Assets.paper,
                value: 'Giấy tờ pháp lý: ${house.legalDocumentStatus}',
              ),
            if (house.houseType != null)
              Detail(
                iconAsset: Assets.home_type,
                value: 'Loại hình căn hộ: ${house.houseType}',
              ),
            if (house.numOfFloors != null)
              Detail(
                iconAsset: Assets.floor,
                value: 'Tầng số: ${house.numOfFloors}',
              ),
            if (house.mainDoorDirection != null)
              Detail(
                iconAsset: Assets.direction,
                value: 'Hướng cửa chính: ${house.mainDoorDirection}',
              ),
          ],
        ));
  }
}