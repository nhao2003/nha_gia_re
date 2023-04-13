import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/data/enums/property_enums.dart';
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source_impl.dart';
import 'package:nha_gia_re/data/providers/remote/request/post_request.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:nha_gia_re/modules/login/screens/register_screen.dart';
import 'package:nha_gia_re/routers/app_pages.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/properties/post.dart';
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
                const Text("LOGO",
                    style: TextStyle(color: Colors.black, fontSize: 64)),
                const SizedBox(
                  height: 50,
                ),
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
                    onPressed: () async {
                      final sp = Supabase.instance.client;
                      final auth = AuthRepository();
                      if (sp.auth.currentUser == null) {
                        try {
                          print("Chưa đăng nhập");
                          final user =
                              await auth.signIn(
                            password: '12345678',
                            email: 'nhathaodx@gmail.com',
                          );
                          print("Success");
                        } catch (e) {
                          print(e.toString());
                        }
                        return;
                      }
                      return;
                      print("Insert");
                      try {
                        await sp.auth.updateUser(UserAttributes(
                            email: '21522046@gm.uit.edu.vn', data: {}));
                        //print(sp.auth.currentUser?.userMetadata);
                      } catch (e) {
                        print('============================');
                        print(e);
                      }
                    },
                    onLongPress: () async {
                      SupabaseClient client = Supabase.instance.client;
                      await client.auth.signOut();
                    },
                    child: Text('Login'.tr)),
                Row(
                  children: [
                    TextButton(
                        onPressed: () async {
                          PostRepository post = PostRepository();
                          Office motel = await post.createPost(
                            OfficeRequest(
                              area: 200,
                              projectName: 'projectName',
                              address: Address(
                                  cityCode: 10,
                                  districtCode: 200,
                                  wardCode: 300),
                              userID: 'd8da06d6-ec21-411c-97cc-dbf991eb3dfc',
                              price: 100,
                              title: 'this is title',
                              description: 'this is description',
                              imagesUrl: [
                                'https://picsum.photos/200/300?random=1',
                                'https://picsum.photos/200/300?random=2',
                                'https://picsum.photos/200/300?random=3'
                              ],
                              isProSeller: true,
                              deposit: 200,
                              hasWideAlley: false,
                              isFacade: false,
                              legalDocumentStatus: null,
                              isLease: true,
                              furnitureStatus: null,
                              officeType: null,
                              mainDoorDirection: Direction.south,
                            ),
                          ) as Office;
                          //Get.to(() => const RegisterScreen());
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
