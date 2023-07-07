import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/data/services/localization_service.dart';
import 'package:nha_gia_re/data/services/onesignal_service.dart';
import 'package:nha_gia_re/routers/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/repositories/account_verification_requests_repository.dart';
import '../../data/repositories/user_repository.dart';

class SettingsController extends GetxController {
  late UserInfo userInfo;
  var userRepo = GetIt.instance<UserRepository>();
  var authRepo = GetIt.instance<AuthRepository>();
  final changePassFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool validatorVisibility = true.obs;
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  RxBool isObscureOldPass = true.obs;
  RxBool isObscureNewPass = true.obs;
  RxBool isObscureRepeatPass = true.obs;
  bool isPasswordCorrect = true;
  RxString selectedLanguage = ''.obs;

  late var languages;

  void handleChangePass() async {
    if (changePassFormKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        var data = await authRepo
            .changePass(oldPassword.text, newPassword.text)
            .then((value) {
          debugPrint(value.toString());
          isLoading.value = false;
          handleChangePassBack();
          Get.snackbar("Notification".tr, "Change password successfully!".tr);
        });
      } on PostgrestException catch (e) {
        if (e.code == 'P0001') {
          isPasswordCorrect = false;
          changePassFormKey.currentState!.validate();
          isPasswordCorrect = true;
        }
        isLoading.value = false;
      } catch (e) {
        debugPrint(e.toString());
        isLoading.value = false;
      }
    }
  }

  void changeLocale(String languageCode) async {
    await LocalizationService.changeLocale(languageCode).then((value) {
      Get.back();
    });
  }

  void handleChangePassBack() {
    oldPassword.text = '';
    newPassword.text = '';
    Get.back();
  }

  String? passValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty.'.tr;
    } else {
      if (!isPasswordCorrect) {
        return 'Incorrect password.'.tr;
      }
      return null;
    }
  }

  String? newPassValidate(String? value) {
    if (oldPassword.text == value) {
      return 'New password cannot be the same as the old password.'.tr;
    }
    return null;
  }

  void toggleOldPass() {
    isObscureOldPass.value = !isObscureOldPass.value;
  }

  void toggleNewPass() {
    isObscureNewPass.value = !isObscureNewPass.value;
  }

  void toggleRepeatPass() {
    isObscureRepeatPass.value = !isObscureRepeatPass.value;
  }

  void showValidator() {
    debugPrint(validatorVisibility.value.toString());
    validatorVisibility.value = true;
  }

  void hideValidator() {
    debugPrint(validatorVisibility.value.toString());
    validatorVisibility.value = false;
  }

  Future<UserInfo> init() async {
    selectedLanguage.value = LocalizationService.getCurrentLanguageCode();
    languages = LocalizationService.langs;
    return await userRepo.getUserInfo();
  }

  void navToFavorite() async {
    var data = {
      "title": 'Favorite'.tr,
      "type": TypeNavigate.favorite,
    };
    Get.toNamed(AppRoutes.resultArg, arguments: data);
  }

  void handleSignOut() async {
    Get.showOverlay(
        asyncFunction: () async {
          return await authRepo.signOut().then((value) {
            OneSignalService.removeExternalId();
            Get.toNamed(AppRoutes.splashScreen);
          });
        },
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ));
  }

  AccountVerificationRepository verifyRepo =
      GetIt.instance<AccountVerificationRepository>();

  Future<String> checkUserIsWaiting() async {
    return await verifyRepo.checkUserIsWaiting();
  }

  void navToUserProfile() {
    Get.toNamed(AppRoutes.userProfile, arguments: userInfo);
  }

  void navToPersonal() {
    Get.toNamed(AppRoutes.personal);
  }

  void navToChangePass() {
    Get.toNamed(AppRoutes.change_pass);
  }

  void navToChangeLang() {
    Get.toNamed(AppRoutes.change_lang);
  }

  Future<String?> navToVerification() async {
    var data = await Get.toNamed(AppRoutes.verification_card_screen);
    return data;
  }

  Future<String?> navToWaitingVerification() async {
    var data = await Get.toNamed(AppRoutes.verification_waiting_screen);
    return data;
  }

  void navToRejectVerification(String rejectInfo) {
    Get.toNamed(AppRoutes.verification_reject_screen, arguments: rejectInfo);
  }

  void navToPurchase() {
    Get.toNamed(AppRoutes.purchase_screen);
  }
}
