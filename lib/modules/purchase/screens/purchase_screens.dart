import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/data/repositories/pay_repository.dart';
import 'package:nha_gia_re/global_widgets/my_circular_process_indicator.dart';
import 'package:nha_gia_re/modules/purchase/screens/purchase_choose_plan_screen.dart';
import 'package:nha_gia_re/modules/purchase/screens/purchase_history_screen.dart';
import 'package:nha_gia_re/modules/purchase/widgets/membership_package_card.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../../data/models/discount.dart';
import '../../../data/models/membership_package.dart';
import '../purchase_controller.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  PurchaseController controller = Get.find<PurchaseController>();
  late ScrollController scrollController = ScrollController();
  bool isScollable = false;
  double quarterScreenHeight = 25.0.hp;

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      setState(() {
        if (scrollController.position.pixels >= quarterScreenHeight) {
          isScollable = true;
        } else {
          isScollable = false;
        }
      });
    });
    return Scaffold(
      floatingActionButton: isScollable
          ? FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                scrollController.animateTo(0,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
            )
          : null,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(PurchaseHistoryScreen());
            },
            icon: const Icon(Icons.history),
          )
        ],
      ),
      body: FutureBuilder<Map<MembershipPackage, Discount?>>(
          future: controller.getMembershipPackageAndDiscount(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: MyCircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              controller: scrollController,
              child: Stack(
                children: [
                  Container(
                    height: 50.0.hp,
                    foregroundDecoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.7),
                    ),
                    child: Image.asset(
                      Assets.landmark_81,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Nhà giá rẻ",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Giải pháp chuyên nghiệp dành cho các nhà Môi giới Bất động sản",
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "Tiết kiệm - Tiện lợi - Hiệu quả",
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ...snapshot.data!.entries
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: MembershipPackageCard(
                                    package: e.key,
                                    discount: e.value,
                                    onTapBuy: (package, discount) {
                                      Get.to(PurchaseChoosePlanScreen(package, discount));
                                    },
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
