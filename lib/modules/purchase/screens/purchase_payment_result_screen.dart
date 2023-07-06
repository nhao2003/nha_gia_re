import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/values/assets_image.dart';

class PurchasePaymentResultScreen extends StatefulWidget {
  final bool status;

  const PurchasePaymentResultScreen(this.status, {super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Lottie.asset(
                  widget.status
                      ? Assets.payment_success
                      : Assets.payment_failure,
                ),
              ),
              Text(
                'Giao dịch${widget.status ? "" : " không"} thành công',
                style: AppTextStyles.roboto20Bold,
              ),
              Text(
                "2.400.000đ",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: widget.status ? AppColors.green : AppColors.red,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                    customText("Mã giao dịch", "0123456789"),
                    customText("Thời gian giao dịch", "00:00 1/1/2003"),
                    customText("Loại giao dịch", "Mua Gói cơ bản 12 Tháng"),
                    customText("Ngày bắt đầu", "00:00 1/1/2023"),
                    customText("Ngày kết thúc", "00:00 1/1/2024"),
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
      ),
    );
  }
}
