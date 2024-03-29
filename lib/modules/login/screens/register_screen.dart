import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/extensions/string_ex.dart';
import 'package:nha_gia_re/modules/login/screens/forget_password.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import '../login_controller.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final LoginController _controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _controller.registerFormGlobalKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(Assets.logoLight, width: 150,height: 150,),
                  Obx(() => TextFormField(
                        controller: _controller.registerEmail,
                        decoration: InputDecoration(
                            hintText: 'Email'.tr,
                            labelText: 'Email',
                            errorText: (_controller.registerError.value == '')
                                ? null
                                : _controller.registerError.value,
                            border: const OutlineInputBorder()),
                        validator: (value) => (value!.isEmail)
                            ? null
                            : 'Invalid email address'.tr,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() => TextFormField(
                        controller: _controller.registerPassword,
                        obscureText: _controller.isObscureRegister.value,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                            hintText: 'Password'.tr,
                            labelText: 'Password'.tr,
                            suffixIcon: IconButton(
                              icon: Icon(!_controller.isObscureRegister.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: _controller.togglePassReg,
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
                          controller: _controller.registerPassword,
                          strings: ValidateString(),
                          minLength: 8,
                          uppercaseCharCount: 1,
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
                              onPressed: _controller.toggleRepeatPassReg,
                            ),
                            border: const OutlineInputBorder()),
                        validator: (value) {
                          if (value != _controller.registerPassword.text) {
                            return "Password doesn't match".tr;
                          }
                          return null;
                        },
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => ElevatedButton(
                      onPressed: _controller.handleRegister,
                      child: _controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ))
                          : Text('Register'.tr))),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Login'.tr)),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Get.to(() => const ForgetPasswordPage());
                          },
                          child: Text('Forgot password?'.tr)),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
