import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/string_ex.dart';
import 'package:nha_gia_re/modules/settings/settings_controller.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final SettingsController _controller = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _controller.handleChangePassBack,
          ),
          title: Text('Change password'.tr)),
      body: Form(
        key: _controller.changePassFormKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Obx(() => TextFormField(
                  obscureText: _controller.isObscureOldPass.value,
                  controller: _controller.oldPassword,
                  autocorrect: false,
                  enableSuggestions: false,
                  validator: _controller.passValidate,
                  decoration: InputDecoration(
                      hintText: 'Enter your current password'.tr,
                      labelText: 'Enter your current password'.tr,
                      suffixIcon: IconButton(
                        icon: Icon(!_controller.isObscureOldPass.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: _controller.toggleOldPass,
                      ),
                      border: const OutlineInputBorder()),
                )),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Obx(() => TextFormField(
                  obscureText: _controller.isObscureNewPass.value,
                  controller: _controller.newPassword,
                  autocorrect: false,
                  enableSuggestions: false,
                  validator: _controller.newPassValidate,
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
                visible: _controller.validatorVisibility.value,
                child: FlutterPwValidator(
                    controller: _controller.newPassword,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    strings: ValidateString(),
                    width: 400,
                    height: 70,
                    onSuccess: _controller.hideValidator,
                    onFail: _controller.showValidator),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => TextFormField(
                  obscureText: _controller.isObscureRepeatPass.value,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      hintText: 'Repeat your password'.tr,
                      labelText: 'Repeat your password'.tr,
                      suffixIcon: IconButton(
                        icon: Icon(!_controller.isObscureRepeatPass.value
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
