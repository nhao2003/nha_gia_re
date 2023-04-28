import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/modules/chat/screens/onChattingScreen.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {

  var loginEmail = TextEditingController();
  var loginPassword = TextEditingController();
  var forgotPassEmail = TextEditingController();
  var registerEmail = TextEditingController();
  var registerPassword = TextEditingController();

  final registerFormGlobalKey = GlobalKey<FormState>();
  final loginFormGlobalKey = GlobalKey<FormState>();  
  final forgotPassFormGlobalKey = GlobalKey<FormState>();

  RxString loginError = RxString('');
  RxString registerError = RxString('');
  RxBool isLoading = false.obs;

  Future<void> handleLogin()
  async {
    final auth = AuthRepository();
    if(loginFormGlobalKey.currentState!.validate())
    {
      print(loginEmail.text + ' ' + loginPassword.text);
      try 
      {
        isLoading.value = true;
        final res = await auth.signIn(email: loginEmail.text, password: loginPassword.text)
        .then((value) => Get.toNamed(AppRoutes.home));
      }
      on AuthException catch (e)
      {
        loginError.value = e.message.tr;
        print(e.message.tr);
      }
      catch (e)
      {
        print(e);
      }
      finally
      {
        isLoading.value = false;
      }
    }
  }
  String? validatePassword(String? value)
  {
    if(value!.isEmpty) return 'Please provide a password'.tr;
    var regex = RegExp(r".{8,}");
    if(!regex.hasMatch(value)) return 'Must be at least 8 characters'.tr;
    regex = RegExp(r"(?=.*[A-Z])");
    if(!regex.hasMatch(value)) return 'Must contain at least one upper case'.tr;
    regex = RegExp(r"(?=.*[a-z])");
    if(!regex.hasMatch(value)) return 'Must contain at least one lower case'.tr;
    return null;
  }
  Future<void> handleRegister()
  async {
    final auth = AuthRepository();
    if(registerFormGlobalKey.currentState!.validate())
    {
      try{
        isLoading.value = true;
        print(registerEmail.text + ' ' + registerPassword.text);
        var user = await auth.signUp(email: registerEmail.text, password: registerPassword.text);
        //print(res);
      }
      on AuthException catch (e)
      {
        registerError.value = e.message.tr;
        print(e.message);
      }
      catch(e)
      {
        print(e);
      }
      finally
      {
        isLoading.value = false;
      }
    }
  }
  Future<void> handleForgotPass()
  async {
    final auth = AuthRepository();
    if(forgotPassFormGlobalKey.currentState!.validate())
    {
      try
      {
        isLoading.value = true;
        print(forgotPassEmail.text);
        await auth.recoveryPassword(forgotPassEmail.text);
      }
      catch (e)
      {
        print(e);
      }
      finally
      {
        isLoading.value = false;
      }
    }
  }
}
