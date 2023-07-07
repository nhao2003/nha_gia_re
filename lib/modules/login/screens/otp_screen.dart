import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/modules/login/login_controller.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:supabase/supabase.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  OtpFieldController otpController = OtpFieldController();
  final LoginController _controller = Get.find<LoginController>();
  String OTPpin = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        titleSpacing: 0,
        title: Text(
          'Forget password'.tr,
          style: AppTextStyles.roboto20semiBold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              Assets.forgetPass,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'OTP'.tr,
              style: TextStyle(color: AppColors.primaryColor, fontSize: 35),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'A 6 digits code has been sent to '.tr,
              style: AppTextStyles.roboto16regular,
            ),
            Text(_controller.forgotPassEmail.text,
                style: AppTextStyles.roboto16regular),
            const SizedBox(
              height: 20,
            ),
            OTPTextField(
              controller: otpController,
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 40,
              style: TextStyle(fontSize: 25),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                OTPpin = pin;
              },
              onChanged: (pin) {},
            ),
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Didn't received the code? ",
                  style: AppTextStyles.roboto14regular),
              Obx(() => (_controller.isCountDown.value) ? Row(
                children: [
                  Text ('Resend in: '.tr ,style: AppTextStyles.roboto14regular),
                  Countdown(
                    controller: _controller.countdownController,
                    seconds: 60,
                    build: (_, double time) => Text(
                      '${time.toStringAsFixed(time.truncateToDouble() == time ? 0 : 1)}s',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    interval: const Duration(seconds: 1),
                    onFinished: () {
                        _controller.isCountDown.value = false;
                    },
                  ),
                ],
              ) : 
              TextButton(onPressed: ()
              {
                _controller.countdownController.restart();
                _controller.isCountDown.value = true;
                _controller.handleForgotPass();
              }, child: Text('RESEND'.tr))
              )
              
            ]),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  AuthRepository auth = GetIt.instance<AuthRepository>();
                  try {
                    await auth
                        .recoveryWithOtp(
                            _controller.forgotPassEmail.text, OTPpin)
                        .then((value) {
                      Get.toNamed(AppRoutes.recoveryPass);
                    });
                  } on AuthException catch (e) {
                    if (e.statusCode == '401') {
                      Get.snackbar(
                          'Notification'.tr, 'OTP has expired or incorrect'.tr);
                    }
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Verify OTP')),
          ],
        ),
      ),
    );
  }
}
