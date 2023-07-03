import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';

import '../login_controller.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  
  final LoginController _controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () { Get.back(); },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        titleSpacing: 0,
        title: Text('Forget password'.tr, style: AppTextStyles.roboto20semiBold,),
        actions: [
          IconButton(onPressed: () {}, icon: Image.asset(Assets.messCircle)),          
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
        ),
      body: Container(
          padding: const EdgeInsets.all(35),
          child: Form(
            key: _controller.forgotPassFormGlobalKey,
            child: Center(
              child: Column(
                children: [
                  Image.asset(Assets.forgetPass, width: MediaQuery.of(context).size.width * 0.65,),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _controller.forgotPassEmail,
                    decoration: InputDecoration(
                        hintText: 'example@email.com',
                        labelText: 'Enter your email'.tr,
                        border: const OutlineInputBorder()),
                    validator: (value) => (value!.isEmail) ? null : 'Invalid email address'.tr,
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _controller.handleForgotPass, 
                      child: _controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ))
                          : Text('Reset password'.tr),),
                    ),
              ]),
            ),
          )),
    );
  }
}