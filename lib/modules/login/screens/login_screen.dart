import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/core/extensions/string_ex.dart';
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source_impl.dart';
import 'package:nha_gia_re/data/providers/remote/request/post_request.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/chat_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/modules/chat/screens/chat_screen.dart';
import 'package:nha_gia_re/modules/login/screens/register_screen.dart';
import 'package:nha_gia_re/routers/app_pages.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/properties/post.dart';
import '../../../data/providers/remote/request/messsage_request.dart';
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
          key: _controller.loginFormGlobalKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("LOGO",
                    style: TextStyle(color: Colors.black, fontSize: 64)),
                const SizedBox(
                  height: 50,
                ),
                Obx(() => TextFormField(
                      controller: _controller.loginEmail,
                      decoration: InputDecoration(
                          hintText: 'Email'.tr,
                          labelText: 'Email',
                          errorText: (_controller.loginError.value == '')
                            ? null
                            : _controller.loginError.value,
                          border: const OutlineInputBorder()),
                      validator: (value) =>
                          (value!.isEmail) ? null : 'Invalid email address'.tr,
                    )),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _controller.loginPassword,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      hintText: 'Password'.tr,
                      labelText: 'Password'.tr,
                      border: const OutlineInputBorder()),
                  validator: (value) => (!(value == null || value == ''))
                      ? null
                      : 'Please provide a password'.tr,
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => ElevatedButton(
                      onPressed: _controller.handleLogin,
                      onLongPress: () async {
                        SupabaseClient client = Supabase.instance.client;
                        await client.auth.signOut();
                      },
                      child: _controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ))
                          : Text('Login'.tr),
                    )),
                Row(
                  children: [
                    TextButton(
                        onPressed: () async {
                          Get.toNamed(AppRoutes.register);
                        },
                        child: Text('Register now'.tr)),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const ForgetPasswordPage());
                        },
                        child: Text('Forgot password?'.tr)),
                  ],
                ),
                Text(
                  "or login with".tr,
                  style: AppTextStyles.roboto16regular,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(Assets.facebook),
                    ),
                    IconButton(
                        onPressed: () {}, icon: Image.asset(Assets.google))
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
