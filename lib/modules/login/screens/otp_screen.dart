import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/modules/login/login_controller.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

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
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter 6 digits code'.tr,
                  style: AppTextStyles.roboto24Bold,
                ),
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
                    AuthRepository auth = GetIt.instance<AuthRepository>();
                    auth.recoveryWithOtp(_controller.forgotPassEmail.text, OTPpin).then((value) {
                      Get.toNamed(AppRoutes.recoveryPass);
                    });
                  },
                  onChanged: (pin) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: (){
                    AuthRepository auth = GetIt.instance<AuthRepository>();
                    auth.recoveryWithOtp(_controller.forgotPassEmail.text, OTPpin).then((value) {
                      Get.toNamed(AppRoutes.recoveryPass);
                    });
                  },
                  child: _controller.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ))
                      : Text('Continute'.tr),
                ),
              ],
            ),
          )),
    );
  }
}
