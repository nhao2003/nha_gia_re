import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/discount.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/purchase/membership_package.dart';
import 'discount_label.dart';

class MembershipPackageCard extends StatelessWidget {
  late final MembershipPackage package;
  late final Discount? discount;
  Function(MembershipPackage package, Discount? discount)? onTapBuy;

  MembershipPackageCard(
      {required this.package, this.discount, this.onTapBuy, super.key});

  Widget textWithCheckIcon(String text, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            status ? Icons.check : Icons.close,
            color: status ? AppColors.green : AppColors.red,
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(width: 2.0, color: AppColors.grey.withOpacity(0.25))),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  package.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (discount != null)
                  DiscountLabel("-${discount!.subscriptionDiscounts[1]}%"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (discount != null)
              Text(
                '${package.price.formatNumberWithCommasK}  VND/THÁNG',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.grey),
              ),
            RichText(
              text: TextSpan(
                text: (discount != null)
                    ? (package.price *
                            (100 - discount!.subscriptionDiscounts[1]!) ~/
                            100)
                        .formatNumberWithCommasK
                    : package.price.formatNumberWithCommasK,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green,
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: ' VND/THÁNG',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(package.description),
            ),
            textWithCheckIcon(
                "${package.monthlyPostLimit} tin đăng/tháng (Hiển thị 14 ngày)",
                true),
            textWithCheckIcon("Ưu tiên hiển thị tin", package.displayPriority),
            textWithCheckIcon(
                "Ưu tiên duyệt tin", package.postApprovalPriority),
            textWithCheckIcon("Huy hiệu xác minh", package.showVerifiedBadge),
            textWithCheckIcon(
                "Ưu tiên chăm sóc khách hàng", package.customerCarePriority),
            textWithCheckIcon("Duyệt tin siêu tốc", package.superFastApproval),
            FractionallySizedBox(
              widthFactor: 1,
              child: ElevatedButton(
                onPressed: onTapBuy != null ? () => onTapBuy!(package, discount) : null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                child: Text("Mua ngay"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
