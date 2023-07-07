import 'dart:io';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';

import '../../data/services/upload_avatar_service.dart';

class VerificationController extends GetxController {
  RxBool isCanClick = false.obs;
  RxInt activeStep = 0.obs;
  int selectedRadio = 0;

  String urlImageCardFront = "";
  String urlImageCardBack = "";
  RxBool isUploadCardFront = false.obs;
  RxBool isUploadCardBack = false.obs;

  final typeIndetificationDocument =
      TypeIndetificationDocument.chungMinhNhanDan.obs;

  void changeStep(int step) {
    activeStep.value = step;
  }

  void continueVerify() {}

  void changeTypeIdentityDocuments(TypeIndetificationDocument type) {
    typeIndetificationDocument.value = type;
    update();
  }

  Future<void> handelUploadIdCard(File file, bool isFront) async {
    if (isFront) {
      urlImageCardFront = await uploadIDCard(file);
      isUploadCardFront.value = true;
      print("urlImageCardFront: $urlImageCardFront");
    } else {
      urlImageCardBack = await uploadIDCard(file);
      isUploadCardBack.value = true;
      print("urlImageCardBack: $urlImageCardBack");
    }
    checkCanClickContinue();
  }

  void checkCanClickContinue() {
    if (isUploadCardFront.value && isUploadCardBack.value) {
      isCanClick.value = true;
    } else {
      isCanClick.value = false;
    }
  }
}
