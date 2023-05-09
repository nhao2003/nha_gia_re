import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/providers/remote/request/update_profile_request.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../data/services/upload_avatar_service.dart';

class UserProfileController extends GetxController {
  var gender = "male".obs;
  var userProfileFormKey = GlobalKey<FormState>();
  var birthDayTextController = TextEditingController();
  var fullNameTextController = TextEditingController();
  var phoneNumberTextController = TextEditingController();
  var bioTextController = TextEditingController();
  var birthday = DateTime.now();
  var isUploadAvatar = false.obs;

  Future<void> handelUploadAvatar(File file) async {
    isUploadAvatar.value = true;
    await uploadAvatar(file).then((value) => isUploadAvatar.value = false);
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required field must not be blank';
    }
    return null;
  }

  Future<void> handleDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light().copyWith(
              primary: Theme.of(context).primaryColor,
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      birthday = picked;
      birthDayTextController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }
  Future<void> handleSubmit()
  async {
    if(userProfileFormKey.currentState!.validate())
    {
      var auth = AuthRepository();
      if(auth.isUserLoggedIn)
      {
        UpdateProfileRequest request = UpdateProfileRequest.name(
          address: Address(cityCode: 1, cityName: '1',districtCode: 1, districtName: '1',wardCode: 1, wardName: '1'), 
          isMale: (gender.value == 'male'), 
          avatarUrl: "avatarUrl", 
          fullName: fullNameTextController.text,
          phoneNumber: phoneNumberTextController.text,
          dob: birthday, 
          description: (bioTextController.text.isEmpty) ? "sao lai ep toi gioi thieu" : bioTextController.text );
        print(request.toJson());
        var response = await auth.updateProfile(request).then((value) => Get.offAllNamed(AppRoutes.home));
      }
    }
  }
}
