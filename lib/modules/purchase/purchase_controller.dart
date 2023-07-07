import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/discount.dart';
import 'package:nha_gia_re/data/models/purchase/membership_package.dart';
import 'package:nha_gia_re/data/models/purchase/membership_package_subscription.dart';
import 'package:nha_gia_re/global_widgets/my_circular_process_indicator.dart';
import 'package:nha_gia_re/modules/purchase/screens/purchase_payment_result_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/purchase/transaction.dart';
import '../../data/providers/remote/request/create_order_request.dart';
import '../../data/providers/remote/request/query_order.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/pay_repository.dart';

class PurchaseController extends GetxController {
  void showPaymentSheet(MembershipPackage package) {}
  PayRepository repository = PayRepository();

  void goToZaloPay(String packageId, int numOfMonth) async {
    CreateOrderRequest request = CreateOrderRequest(
        record: Record(
      userId: GetIt.instance<AuthRepository>().userID!,
      numOfSubscriptionMonth: numOfMonth,
      membershipPackageId: packageId,
    ));
    Get.dialog(const Center(child: MyCircularProgressIndicator()));
    await PayRepository.createOrder(request).then((value) {
      if (value != null) {
        FlutterZaloPaySdk.payOrder(zpToken: value.zptranstoken).listen((event) {
          QueryOrder query = QueryOrder(
              record: QueryRecord(
            userId: GetIt.instance<AuthRepository>().userID!,
            apptransid: value.apptransid,
          ));
          PayRepository.createQuery(query).then((value) {
            var status = event;
            var data = value;
            final String id = value!.transactionid;
            Get.offAll(() => PurchasePaymentResultScreen(transId: id,));
          });
        });
      }
    });
  }

  Future<Map<MembershipPackage, Discount?>>
      getMembershipPackageAndDiscount() async {
    final mps = await repository.getMembershipPackage();
    final discounts = await repository.getDiscount();
    final discountMap = Map<String, Discount?>.fromIterable(discounts,
        key: (d) => d.membershipPackageId);
    final res =
        mps.fold<Map<MembershipPackage, Discount?>>({}, (result, package) {
      final discount = discountMap[package.id];
      result[package] = discount;
      return result;
    });
    return res;
  }

  Future<
          MapEntry<Transaction,
              MapEntry<MembershipPackage, MembershipPackageSubscription?>>>
      initPurchaseResultScreen({String? transId, dynamic data}) async {

    if(data is MapEntry<Transaction,
        MapEntry<MembershipPackage, MembershipPackageSubscription?>>){
      return data;
    } else {
      return  await repository.getDetailTransaction(transId!);
    }
  }


  Future<
          List<
              MapEntry<Transaction,
                  MapEntry<MembershipPackage, MembershipPackageSubscription?>>>>
      getUserTransactions() async {
    return await repository.getUserTransactions();
  }
}
