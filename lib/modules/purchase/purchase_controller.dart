import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/discount.dart';
import 'package:nha_gia_re/data/models/membership_package.dart';
import 'package:nha_gia_re/global_widgets/my_circular_process_indicator.dart';
import 'package:nha_gia_re/modules/purchase/screens/purchase_payment_result_screen.dart';

import '../../data/providers/remote/request/create_order_request.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/pay_repository.dart';

class PurchaseController extends GetxController {
  void showPaymentSheet(MembershipPackage package) {}
  PayRepository repository = PayRepository();

  void goToZaloPay(int amount) async {
    log("Hello");
    String payResult = "";
    CreateOrderRequest request = CreateOrderRequest(
        record: Record(
            userId: GetIt.instance<AuthRepository>().userID!,
            amount: amount,
            embeddata: "embeddata",
            property: "property info"));
    Get.dialog(const Center(child: MyCircularProgressIndicator()));
    await PayRepository.createOrder(request).then((value) {
      if (value != null) {
        FlutterZaloPaySdk.payOrder(zpToken: value.data.zptranstoken)
            .listen((event) {
          switch (event) {
            case FlutterZaloPayStatus.cancelled:
              payResult = "User Huỷ Thanh Toán";
              Get.to(() => const PurchasePaymentResultScreen(false));
              return;
            case FlutterZaloPayStatus.success:
              payResult = "Thanh toán thành công";
              Get.offAll(() => const PurchasePaymentResultScreen(true));
              return;
              break;
            case FlutterZaloPayStatus.failed:
              payResult = "Thanh toán thất bại";
              Get.to(() => const PurchasePaymentResultScreen(false));
              return;
              break;
            default:
              payResult = "Thanh toán thất bại";
              Get.to(() => const PurchasePaymentResultScreen(false));
              return;
              break;
          }
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
}
