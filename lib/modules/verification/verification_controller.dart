import 'dart:io';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../data/services/upload_avatar_service.dart';

class VerificationController extends GetxController {
  RxBool isCanClickCard = false.obs;
  RxBool isCanClickPortrait = false.obs;
  RxBool isCanClickInfo = false.obs;
  RxInt activeStep = 0.obs;
  int selectedRadio = 0;

  String urlImageCardFront = "";
  String urlImageCardBack = "";
  RxBool isUploadCardFront = false.obs;
  RxBool isUploadCardBack = false.obs;

  String urlImagePortrait = "";

  final typeIndetificationDocument =
      TypeIndetificationDocument.chungMinhNhanDan.obs;

  void changeStep(int step) {
    activeStep.value = step;
  }

  void changeTypeIdentityDocuments(TypeIndetificationDocument type) {
    typeIndetificationDocument.value = type;
    update();
  }

  Future<void> handelUploadIdCard(File file, bool isFront) async {
    if (isFront) {
      urlImageCardFront = await uploadIDCard(file);
      isUploadCardFront.value = true;
    } else {
      urlImageCardBack = await uploadIDCard(file);
      isUploadCardBack.value = true;
    }
    checkCanClickContinueCard();
  }

  Future<void> handelUploadPortrait(File file) async {
    urlImagePortrait = await uploadPortrait(file);
    isCanClickPortrait.value = true;
  }

  void checkCanClickContinueCard() {
    if (isUploadCardFront.value && isUploadCardBack.value) {
      isCanClickCard.value = true;
    } else {
      isCanClickCard.value = false;
    }
  }

  void navToPortraitSceen() {
    if (isCanClickCard.value) {
      Get.toNamed(AppRoutes.verification_portrait_screen);
      isCanClickPortrait.value = false;
      changeStep(1);
    }
  }

  void navToInforScreen() {
    if (isCanClickPortrait.value) {
      Get.toNamed(AppRoutes.verification_info_screen);
      isCanClickInfo.value = false;
      changeStep(2);
    }
  }

  void finishVerification() {}
}
