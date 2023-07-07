import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/models/purchase/transaction.dart';
import 'package:nha_gia_re/modules/purchase/purchase_controller.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/values/assets_image.dart';
import '../../../data/models/purchase/membership_package.dart';
import '../../../data/models/purchase/membership_package_subscription.dart';

class PurchasePaymentResultScreen extends StatefulWidget {
  final String? transId;
  final dynamic data;

  const PurchasePaymentResultScreen({this.transId, this.data, super.key})
      : assert(transId != null || data != null);

  @override
  State<PurchasePaymentResultScreen> createState() =>
      _PurchasePaymentResultScreenState();
}

class _PurchasePaymentResultScreenState
    extends State<PurchasePaymentResultScreen> {
  Widget customText(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              text1,
              style:
                  AppTextStyles.roboto14regular.copyWith(color: AppColors.grey),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              text2,
              style: AppTextStyles.roboto15semiBold,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  PurchaseController controller = Get.find<PurchaseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
            ),
            onPressed: () {
              Get.offAllNamed(AppRoutes.tabScreen);
            },
            child: Text(
              "Trở về màn hình chính",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<
              MapEntry<Transaction,
                  MapEntry<MembershipPackage, MembershipPackageSubscription?>>>(
          future: controller.initPurchaseResultScreen(
              transId: widget.transId, data: widget.data),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            final data = snapshot.data;
            final trans = snapshot.data!.key;
            final package = snapshot.data!.value.key;
            final sub = snapshot.data!.value.value;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Lottie.asset(
                        trans.isSuccess
                            ? Assets.payment_success
                            : Assets.payment_failure,
                      ),
                    ),
                    Text(
                      'Giao dịch${trans.isSuccess ? "" : " không"} thành công',
                      style: AppTextStyles.roboto20Bold,
                    ),
                    Text(
                      "${trans.amount.formatNumberWithCommas}đ",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color:
                            trans.isSuccess ? AppColors.green : AppColors.red,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: AppColors.secondary,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          customText("Mã giao dịch", trans.id),
                          customText("Thời gian giao dịch",
                              trans.timeStamp.toHMDMYString()),
                          customText("Loại giao dịch",
                              "Mua ${package.name} ${trans.numOfSubscriptionMonth} tháng"),
                          customText("Ngày bắt đầu",
                              sub?.startDate.toHMDMYString() ?? ""),
                          customText("Ngày kết thúc",
                              sub?.endDate.toHMDMYString() ?? ""),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.info,
                                color: AppColors.grey,
                                size: 18,
                              ),
                            ),
                            TextSpan(
                                text:
                                    " Bạn có thể thể xem lại giao dịch trong lịch sử giao dịch. Nếu bạn cần giúp đỡ có thể liện hệ qua ",
                                style: TextStyle(
                                  color: AppColors.black,
                                )),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse("tel://0987654321"));
                                },
                                child: Text(
                                  "0987654321",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            TextSpan(
                                text: " hoặc ",
                                style: TextStyle(
                                  color: AppColors.black,
                                )),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  launchUrl(Uri.parse("mailto://abc@abc.com"));
                                },
                                child: Text(
                                  "abc@abc.com",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
