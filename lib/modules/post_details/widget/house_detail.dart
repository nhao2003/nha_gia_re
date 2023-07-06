import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';
import '../../../core/values/assets_image.dart';

class HouseDetails extends StatelessWidget {
  const HouseDetails({Key? key, required this.house}) : super(key: key);

  final House house;

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
          if (house.isLease)
            Detail(
              iconAsset: Assets.ad_type,
              value: 'For Lease'.tr,
            ),
          if (house.deposit != null)
            Detail(
              iconAsset: Assets.deposit,
              value: '${'Deposit:'.tr} ${house.deposit?.toFormattedMoney()}'.tr,
            ),
          Detail(
            iconAsset: Assets.area,
            value: '${'Area:'.tr} ${house.area} m2',
          ),
          Detail(
            iconAsset: Assets.price_m2,
            value: '${'Price/m2:'.tr} ${(house.price / house.area).toFormattedMoney()}',
          ),
          if (house.width != null)
            Detail(
              iconAsset: Assets.width,
              value: '${'Width:'.tr} ${house.width}',
            ),
          if (house.length != null)
            Detail(
              iconAsset: Assets.length,
              value: '${'Length:'.tr} ${house.length}',
            ),
          if (house.furnitureStatus != null)
            Detail(
              iconAsset: Assets.furnishing_sell,
              value: '${'Furniture Status:'.tr} ${house.furnitureStatus.toString().tr}',
            ),
          if (house.numOfBedRooms != null)
            Detail(
              iconAsset: Assets.room_num,
              value: '${'Number of Bedrooms:'.tr} ${house.numOfBedRooms} ${'rooms'.tr}',
            ),
          if (house.numOfToilets != null)
            Detail(
              iconAsset: Assets.toilets,
              value: '${'Number of Toilets:'.tr} ${house.numOfToilets} ${'rooms'.tr}',
            ),
          if (house.legalDocumentStatus != null)
            Detail(
              iconAsset: Assets.paper,
              value: '${'Legal Document:'.tr} ${house.legalDocumentStatus.toString().tr}',
            ),
          if (house.houseType != null)
            Detail(
              iconAsset: Assets.home_type,
              value: '${'House Type:'.tr} ${house.houseType.toString().tr}',
            ),
          if (house.numOfFloors != null)
            Detail(
              iconAsset: Assets.floor,
              value: '${'Number of Floors:'.tr} ${house.numOfFloors}',
            ),
          if (house.mainDoorDirection != null)
            Detail(
              iconAsset: Assets.direction,
              value: '${'Main Door Direction:'.tr} ${house.mainDoorDirection.toString().tr}',
            ),
        ],
      ),
    );
  }
}
