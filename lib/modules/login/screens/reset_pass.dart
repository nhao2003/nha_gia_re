
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/string_ex.dart';
import 'package:nha_gia_re/modules/login/login_controller.dart';

class RecoveryPassScreen extends StatefulWidget {
  const RecoveryPassScreen({super.key});

  @override
  State<RecoveryPassScreen> createState() => _RecoveryPassScreenState();
}

class _RecoveryPassScreenState extends State<RecoveryPassScreen> {
  final LoginController _controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Text('Change password'.tr)),
      body: Form(
        key: _controller.changePassFormKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Obx(() => TextFormField(
                  obscureText: _controller.isObscureNewPass.value,
                  controller: _controller.newPassword,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      hintText: 'Enter your new password'.tr,
                      labelText: 'Enter your new password'.tr,
                      suffixIcon: IconButton(
                        icon: Icon(!_controller.isObscureNewPass.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: _controller.toggleNewPass,
                      ),
                      border: const OutlineInputBorder()),
                )),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Visibility(
                visible: _controller.validatorChangePassVisibility.value,
                child: FlutterPwValidator(
                    controller: _controller.newPassword,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    strings: ValidateString(),
                    width: 400,
                    height: 70,
                    onSuccess: _controller.hideChangePassValidator,
                    onFail: _controller.showChangePassValidator),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => TextFormField(
                  obscureText: _controller.isObscureRepeatPassReset.value,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      hintText: 'Repeat your password'.tr,
                      labelText: 'Repeat your password'.tr,
                      suffixIcon: IconButton(
                        icon: Icon(!_controller.isObscureRepeatPassReset.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: _controller.toggleRepeatPass,
                      ),
                      border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value != _controller.newPassword.text) {
                      return "Password doesn't match".tr;
                    }
                    return null;
                  },
                )),
            const SizedBox(
              height: 10,
            ),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _controller.handleChangePass,
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                      child: _controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ))
                          : Text('Save'.tr)),
                )),
          ]),
        ),
      ),
    );
  }
}
