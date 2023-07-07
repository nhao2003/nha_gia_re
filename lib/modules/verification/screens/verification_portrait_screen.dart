import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/verification/verification_controller.dart';
import 'package:nha_gia_re/modules/verification/widgets/choose_image_portrait.dart';
import 'package:nha_gia_re/modules/verification/widgets/stepper_identify.dart';

class verificationPortraitScreen extends StatelessWidget {
  verificationPortraitScreen({super.key});
  final VerificationController _controller = Get.find<VerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Chụp ảnh chân dung"),
      ),
      // body
      body: Column(
        children: [
// container steps
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Column(
              children: [
                Text(
                  "Vui lòng cung cấp cho chúng tôi hình ảnh thật chân dung của bạn.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.roboto14Bold,
                ),
                const SizedBox(height: 10),
                StepperIdentify(1),
              ],
            ),
          ),
// change type identity documents
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            width: double.infinity,
            child: ChooseImagePortrait(_controller),
          ),
        ],
      ),

      // bottom button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: _controller.isCanClickPortrait.value
                ? () {
                    _controller.navToInforScreen();
                  }
                : null,
            child: Center(
              child: Text(
                'Continue'.tr,
                style: AppTextStyles.roboto16Bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
