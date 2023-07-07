import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/discount.dart';
import 'package:nha_gia_re/data/models/purchase/membership_package.dart';
import 'package:nha_gia_re/data/providers/remote/request/create_order_request.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/pay_repository.dart';
import 'package:nha_gia_re/modules/purchase/purchase_controller.dart';
import 'package:nha_gia_re/modules/purchase/widgets/discount_label.dart';

import '../../../core/theme/app_colors.dart';

class PurchaseChoosePlanScreen extends StatefulWidget {
  final MembershipPackage package;
  final Discount? discount;

  const PurchaseChoosePlanScreen(this.package, this.discount, {super.key});

  @override
  State<PurchaseChoosePlanScreen> createState() =>
      _PurchaseChoosePlanScreenState();
}

class _PurchaseChoosePlanScreenState extends State<PurchaseChoosePlanScreen> {
  int selectedRadio = -1;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  PurchaseController controller = Get.find<PurchaseController>();

  List<int> unionLists(List<int> list1, List<int> list2) {
    Set<int> unionSet = Set<int>.from(list1);
    unionSet.addAll(list2);
    return unionSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> months = unionLists(
        widget.discount?.subscriptionDiscounts.keys.toList() ?? [],
        [1, 3, 6, 12]);
    final percentage = months
        .map((e) => (widget.discount != null)
            ? widget.discount?.subscriptionDiscounts[e] ?? 0
            : 0)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.package.name),
      ),
      bottomSheet: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
            ),
            onPressed: selectedRadio != -1
                ? () => controller.goToZaloPay(
                    widget.package.id, months[selectedRadio])
                : null,
            child: Text(
              "Mua ngay",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: months.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                tileColor: selectedRadio == index
                    ? AppColors.green.withOpacity(0.15)
                    : null,
                onTap: () {
                  setState(() {
                    selectedRadio = index;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.green,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                leading: Radio(
                  fillColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.green),
                  value: index,
                  groupValue: selectedRadio,
                  onChanged: (val) {
                    setSelectedRadio(val!);
                  },
                ),
                trailing: (percentage[index] != 0)
                    ? DiscountLabel("-${percentage[index]}%")
                    : null,
                title: Text("Gói ${months[index]} tháng"),
                subtitle: RichText(
                  text: TextSpan(
                    children: [
                      if (percentage[index] != 0)
                        TextSpan(
                          text:
                              "${(widget.package.price * months[index]).formatNumberWithCommas}đ",
                          style: TextStyle(
                            color: AppColors.grey,
                            decoration: (percentage[index] != 0)
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      if (percentage[index] != 0) const TextSpan(text: "  "),
                      TextSpan(
                        text:
                            "${(widget.package.price * months[index] * (1 - percentage[index] / 100)).toInt().formatNumberWithCommas}đ",
                        style: TextStyle(
                          color: AppColors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
