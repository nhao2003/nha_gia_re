import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';
import 'package:nha_gia_re/data/services/onesignal_service.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {

  var loginEmail = TextEditingController(text: 'tienanhnguyen996@gmail.com');
  var loginPassword = TextEditingController(text: 'Nguyen123');
  var forgotPassEmail = TextEditingController();
  var registerEmail = TextEditingController();
  var registerPassword = TextEditingController();
  var newPassword = TextEditingController();

  final registerFormGlobalKey = GlobalKey<FormState>();
  final loginFormGlobalKey = GlobalKey<FormState>();
  final forgotPassFormGlobalKey = GlobalKey<FormState>();
  final changePassFormKey = GlobalKey<FormState>();

  RxString loginError = RxString('');
  RxString registerError = RxString('');
  RxBool isLoading = false.obs;
  RxBool isObscureNewPass = true.obs;
  RxBool isObscureLogin = true.obs;
  RxBool isObscureRegister = true.obs;
  RxBool isObscureRepeatPass = true.obs; 
   RxBool isObscureRepeatPassReset = true.obs;
  RxBool validatorVisibility = true.obs;
  RxBool validatorChangePassVisibility = true.obs;


  void handleChangePass() async {
    if(changePassFormKey.currentState!.validate())
    {
      UserRepository user = GetIt.instance<UserRepository>();
      await user.updatePass(newPassword.text).then((value) {
        Get.offAllNamed(AppRoutes.login);
        Get.snackbar('Notification'.tr, 'Your password has change successfully.'.tr);
        });
    }
  }

  void toggleNewPass() {
    isObscureNewPass.value = !isObscureNewPass.value;
  }

  void toggleRepeatPass() {
    isObscureRepeatPassReset.value = !isObscureRepeatPassReset.value;
  }

  void togglePassword()
  {
    isObscureLogin.value = !isObscureLogin.value;
  }
  void togglePassReg()
  {
    isObscureRegister.value = !isObscureRegister.value;
  }
  void toggleRepeatPassReg()
  {
    isObscureRepeatPass.value = !isObscureRepeatPass.value;
  }
  Future<void> handleLogin()
  async {
    final auth = GetIt.instance<AuthRepository>();
    if(loginFormGlobalKey.currentState!.validate())
    {
      print(loginEmail.text + ' ' + loginPassword.text);
      try
      {
        isLoading.value = true;
        final res = await auth.signIn(email: loginEmail.text, password: loginPassword.text)
        .then((value) {
          OneSignalService.addExternalId(value.uid);
          if(value.updatedDate == null)
          {
            Get.offAllNamed(AppRoutes.userProfile);
          }
          else
          {
            Get.offAllNamed(AppRoutes.tabScreen);
          }
        });
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
    void showChangePassValidator()
  {
    validatorChangePassVisibility.value = true;
  }
   void hideChangePassValidator()
  {
    validatorChangePassVisibility.value = false;
  }
  void showValidator()
  {
    debugPrint(validatorVisibility.value.toString());
    validatorVisibility.value = true;
  }
   void hideValidator()
  {
    debugPrint(validatorVisibility.value.toString());
    validatorVisibility.value = false;
  }
  Future<void> handleRegister()
  async {
    final auth = GetIt.instance<AuthRepository>();
    if(registerFormGlobalKey.currentState!.validate())
    {
      try{
        isLoading.value = true;
        print(registerEmail.text + ' ' + registerPassword.text);
        var user = await auth.signUp(email: registerEmail.text, password: registerPassword.text).then((value) {
          Get.back();
          Get.snackbar('Notification'.tr, 'Register successfully. Check you email for confirmation mail.'.tr);
        });        //print(res);
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
    final auth = GetIt.instance<AuthRepository>();
    if(forgotPassFormGlobalKey.currentState!.validate())
    {
      try
      {
        isLoading.value = true;
        print(forgotPassEmail.text);
        await auth.recoveryPassword(forgotPassEmail.text).then((value) {
          Get.toNamed(AppRoutes.otp);
          Get.snackbar('Notification'.tr, 'Please check your email for reset password mail.'.tr); 
        });
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
