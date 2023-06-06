import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/modules/login/screens/forget_password.dart';
import 'package:nha_gia_re/modules/login/screens/login_screen.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../../core/theme/text_styles.dart';
import '../login_controller.dart';

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
      body: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _controller.registerFormGlobalKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("LOGO", style: TextStyle(color: Colors.black, fontSize: 64)),
                  const SizedBox(height: 50,),
                  Obx( () => TextFormField(
                    controller: _controller.registerEmail,
                    decoration: InputDecoration(
                        hintText: 'Email'.tr,
                        labelText: 'Email',
                        errorText: (_controller.registerError.value == '')
                          ? null
                          : _controller.registerError.value,
                        border: const OutlineInputBorder()),
                    validator: (value) => (value!.isEmail) ? null : 'Invalid email address'.tr,
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _controller.registerPassword,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                        hintText: 'Password'.tr,
                        labelText: 'Password'.tr,
                        border: const OutlineInputBorder()
                        ),
                    validator: _controller.validatePassword,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                        hintText: 'Repeat your password'.tr,
                        labelText: 'Repeat your password'.tr,
                        border: const OutlineInputBorder()),
                    validator: (value) {
                      if(value != _controller.registerPassword.text) {
                        return "Password doesn't match".tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx( () => ElevatedButton(
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
                          onPressed: () { Get.back(); }, child: Text('Login'.tr)),
                      const Spacer(),
                      TextButton(
                          onPressed: () { Get.to(() => const ForgetPasswordPage()); }, child: Text('Forgot password?'.tr)),
                    ],
                  ),
                ]),
          ),
        ),
    );
  }
}
