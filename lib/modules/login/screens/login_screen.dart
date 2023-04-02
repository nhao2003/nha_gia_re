import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/modules/login/screens/register_screen.dart';
import 'package:nha_gia_re/routers/app_pages.dart';

import '../login_controller.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginController _controller = Get.find<LoginController>();
  final loginFormGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: loginFormGlobalKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("LOGO", style: TextStyle(color: Colors.black, fontSize: 64)),
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
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      hintText: 'Password'.tr,
                      labelText: 'Password'.tr,
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (loginFormGlobalKey.currentState!.validate()) {

                      }
                    }, 
                    child: Text('Login'.tr)),
                Row(
                  children: [
                    TextButton(
                        onPressed: () { Get.to(() => const RegisterScreen()); }, child: Text('Register now'.tr)),
                    const Spacer(),
                    TextButton(
                        onPressed: () { Get.to(() => const ForgetPasswordPage()); }, child: Text('Forgot password?'.tr)),
                  ],
                ),
                Text(
                  "or login with".tr,
                  style: AppTextStyles.roboto16regular,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: () {}, icon: Image.asset(Assets.facebook),),
                    IconButton(onPressed: () {}, icon: Image.asset(Assets.google))
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
