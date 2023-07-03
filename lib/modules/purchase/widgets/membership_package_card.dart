import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/membership_package.dart';

class MembershipPackageCard extends StatelessWidget {
  late MembershipPackage package = MembershipPackage.createFakeData().first;
  Function(MembershipPackage package)? onTapBuy;

  MembershipPackageCard({required this.package, this.onTapBuy, super.key});

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

  String formatNumberWithCommas(int number) {
    if (number >= 1000000) {
      String strNumber = (number / 1000).toString();
      String result = '';
      for (int i = strNumber.length - 1; i >= 0; i--) {
        result = strNumber[i] + result;
        if ((strNumber.length - i) % 3 == 0 && i > 0) {
          result = '.$result';
        }
      }
      return "${result}K";
    } else if (number >= 1000) {
      double value = number / 1000;
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}K';
    } else {
      return number.toString();
    }
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "80%",
                    style: TextStyle(color: AppColors.red),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: formatNumberWithCommas(package.price),
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.grey
                ),
                children: const <TextSpan>[
                  TextSpan(
                    text: ' VND/THÁNG',
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: formatNumberWithCommas(package.price),
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
                onPressed: onTapBuy != null ? () =>  onTapBuy!(package) : null,
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
