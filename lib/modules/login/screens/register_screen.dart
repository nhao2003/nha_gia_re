import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/login/screens/forget_password.dart';
import 'package:nha_gia_re/modules/login/screens/login_screen.dart';

import '../../../core/theme/text_styles.dart';
import '../login_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final LoginController _controller = Get.find<LoginController>();
  final registerFormGlobalKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: registerFormGlobalKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("LOGO", style: CustomTextStyle.logo(Colors.black), textAlign: TextAlign.center,),
                  const SizedBox(height: 50,),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Email'.tr,
                        labelText: 'Email',
                        border: const OutlineInputBorder()),
                    validator: _controller.validateEmail,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _pass,
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
                      if(value != _pass.text) {
                        return "Password doesn't match".tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (registerFormGlobalKey.currentState!.validate()) {}
                      }, 
                      child: Text('Register'.tr)),
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
