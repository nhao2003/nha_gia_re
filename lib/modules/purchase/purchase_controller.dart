import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/models/membership_package.dart';
import 'package:nha_gia_re/modules/purchase/screens/purchase_payment_result_screen.dart';

import '../../data/providers/remote/request/create_order_request.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/pay_repository.dart';

class PurchaseController extends GetxController {
  void showPaymentSheet(MembershipPackage package) {}

  void goToZaloPay(int amount) async {
    log("Hello");
    String payResult = "";
    CreateOrderRequest request = CreateOrderRequest(
        record: Record(
            userId: GetIt.instance<AuthRepository>().userID!,
            amount: amount,
            embeddata: "embeddata",
            property: "property info"));
    await PayRepository.createOrder(request).then((value) {
      if (value != null) {
        FlutterZaloPaySdk.payOrder(zpToken: value.data.zptranstoken)
            .listen((event) {
          switch (event) {
            case FlutterZaloPayStatus.cancelled:
              payResult = "User Huỷ Thanh Toán";
              Get.to(() => const PurchasePaymentResultScreen(false));
              return;
              Future.delayed(const Duration(seconds: 2), () {
                Get.snackbar("Trạng thái", payResult);
              });
              break;
            case FlutterZaloPayStatus.success:
              payResult = "Thanh toán thành công";
              Get.to(() => const PurchasePaymentResultScreen(true));
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
}
