import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';

import '../login_controller.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  
  final LoginController _controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _controller.formGlobalKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("LOGO", style: CustomTextStyle.logo(Colors.black), textAlign: TextAlign.center,),
                const SizedBox(height: 50,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter your email'.tr,
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
                      hintText: 'Enter your email'.tr,
                      labelText: 'Password'.tr,
                      border: const OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {}, child: Text('Login'.tr)),
                Row(
                  children: [
                    TextButton(
                        onPressed: () { }, child: Text('Register'.tr)),
                    const Spacer(),
                    TextButton(
                        onPressed: () {}, child: Text('Forgot password?'.tr)),
                  ],
                ),
                Text(
                  "or login with".tr,
                  style: CustomTextStyle.login(Colors.grey),
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
      );
  }
}