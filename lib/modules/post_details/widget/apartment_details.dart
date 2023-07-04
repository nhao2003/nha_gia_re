import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/modules/post_details/widget/details.dart';
import '../../../core/values/assets_image.dart';

class ApartmentDetails extends StatelessWidget {
  const ApartmentDetails({Key? key, required this.apartment}) : super(key: key);

  final Apartment apartment;

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
          if (apartment.isLease)
            Detail(
              iconAsset: Assets.ad_type,
              value: 'For Lease'.tr,
            ),
          if (apartment.deposit != null)
            Detail(
              iconAsset: Assets.deposit,
              value: '${'Deposit:'.tr} ${apartment.deposit?.toFormattedMoney()}',
            ),
          Detail(
            iconAsset: Assets.property_status,
            value: '${'Property Status:'.tr} ${apartment.isHandOver ? 'Handed Over'.tr : 'Not Handed Over'.tr}',
          ),
          if (apartment.furnitureStatus != null)
            Detail(
              iconAsset: Assets.furnishing_sell,
              value: '${'Furniture Status:'.tr} ${apartment.furnitureStatus.toString().tr}',
            ),
          Detail(
            iconAsset: Assets.area,
            value: '${'Area:'.tr} ${apartment.area} m2',
          ),
          Detail(
            iconAsset: Assets.price_m2,
            value: '${'Price/m2:'.tr} ${(apartment.price / apartment.area).toFormattedMoney()}',
          ),
          if (apartment.block != null)
            Detail(
              iconAsset: Assets.block,
              value: '${'Block Name:'.tr} ${apartment.block}',
            ),
          if (apartment.numOfBedRooms != null)
            Detail(
              iconAsset: Assets.room_num,
              value: '${'Number of Bedrooms:'.tr} ${apartment.numOfBedRooms} ${'rooms'.tr}',
            ),
          if (apartment.numOfToilets != null)
            Detail(
              iconAsset: Assets.toilets,
              value: '${'Number of Toilets:'.tr} ${apartment.numOfToilets} ${'rooms'.tr}',
            ),
          if (apartment.legalDocumentStatus != null)
            Detail(
              iconAsset: Assets.paper,
              value: '${'Legal Document:'.tr} ${apartment.legalDocumentStatus.toString().tr}',
            ),
          if (apartment.apartmentType != null)
            Detail(
              iconAsset: Assets.commercial_type,
              value: '${'Apartment Type:'.tr} ${apartment.apartmentType.toString().tr}',
            ),
          if (apartment.floor != null)
            Detail(
              iconAsset: Assets.floornumber,
              value: '${'Floor:'.tr} ${apartment.floor}',
            ),
          if (apartment.mainDoorDirection != null)
            Detail(
              iconAsset: Assets.direction,
              value: '${'Main Door Direction:'.tr} ${apartment.mainDoorDirection.toString().tr}',
            ),
          if (apartment.balconyDirection != null)
            Detail(
              iconAsset: Assets.balconyDirection,
              value: '${'Balcony Direction:'.tr} ${apartment.balconyDirection.toString().tr}',
            ),
          if (apartment.isCorner)
            Detail(
              iconAsset: Assets.apartment_feature,
              value: 'Corner Apartment'.tr,
            ),
        ],
      ),
    );
  }
}
