import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/data/models/purchase/transaction.dart';
import 'package:nha_gia_re/global_widgets/my_circular_process_indicator.dart';
import 'package:nha_gia_re/modules/purchase/screens/purchase_payment_result_screen.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/purchase/membership_package.dart';
import '../../../data/models/purchase/membership_package_subscription.dart';
import '../purchase_controller.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  @override
  _PurchaseHistoryScreenState createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  PurchaseController controller = Get.find<PurchaseController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
      ),
      body: FutureBuilder<
              List<
                  MapEntry<
                      Transaction,
                      MapEntry<MembershipPackage,
                          MembershipPackageSubscription?>>>>(
        future: controller.getUserTransactions(),
          builder: (context, snapshot) {
        if (!snapshot.hasData) {
          const Center(
            child: MyCircularProgressIndicator(),
          );
        }
        final List<
                MapEntry<
                    Transaction,
                    MapEntry<MembershipPackage,
                        MembershipPackageSubscription?>>> data =
            snapshot.data ?? [];
        return ListView.separated(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final transaction = data[index].key;
            final package = data[index].value.key;
            final sub = data[index].value.value;
            return ListTile(
              onTap: (){
                Get.to(() => PurchasePaymentResultScreen(data: data[index],));
              },
              leading: Icon(Icons.shopping_cart),
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text("${package.name} ${transaction.numOfSubscriptionMonth} tháng"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Thời gian giao dịch: ${transaction.timeStamp.toHMDMYString()}'),
                  Text(
                    '${transaction.amount.formatNumberWithCommas}đ',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.black),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      }),
    );
  }
}
