import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/models/user_info.dart';
import 'package:nha_gia_re/data/providers/remote/request/update_profile_request.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

import '../../data/services/upload_avatar_service.dart';

class UserProfileController extends GetxController {
  late String avatarUrl;
  var gender = "male".obs;
  var userProfileFormKey = GlobalKey<FormState>();
  var birthDayTextController = TextEditingController();
  var fullNameTextController = TextEditingController();
  var phoneNumberTextController = TextEditingController();
  var bioTextController = TextEditingController();
  late Address address;
  final TextEditingController addressController = TextEditingController();
  var birthday = DateTime.now();
  var isUploadAvatar = false.obs;

  void init(dynamic arg) {
    if (arg is UserInfo) {
      avatarUrl = arg.avatarUrl!;
      fullNameTextController.text = arg.fullName!;
      phoneNumberTextController.text = arg.phoneNumber!;
      gender.value = (arg.isMale!) ? 'male' : 'female';
      birthDayTextController.text = DateFormat('dd/MM/yyyy').format(arg.dob!);
      bioTextController.text = arg.description!;
      addressController.text = arg.address.toString();
      address = arg.address!;
    } else {
      avatarUrl =
          'https://th.bing.com/th/id/OIP.IinrjlpXbDCJt28EGzYHfQHaHa?pid=ImgDet&rs=1';
    }
  }

  Future<void> handelUploadAvatar(File file) async {
    isUploadAvatar.value = true;
    avatarUrl = await uploadAvatar(file).then((value) {
      isUploadAvatar.value = false;
      return value;
    });
  }

  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required field must not be blank';
    }
    return null;
  }

  void handleAddress() async {
    address = await Get.toNamed(AppRoutes.address)!.then((value) {
      if (value != null) {
        addressController.text = value.toString();
        return value;
      } else
        return address;
    });
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
            colorScheme: const ColorScheme.light().copyWith(
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

  Future<void> handleSubmit() async {
    if (userProfileFormKey.currentState!.validate()) {
      final auth = GetIt.instance<AuthRepository>();
      if (auth.isUserLoggedIn) {
        UpdateProfileRequest request = UpdateProfileRequest.name(
            address: address,
            isMale: (gender.value == 'male'),
            avatarUrl: avatarUrl,
            fullName: fullNameTextController.text,
            phoneNumber: phoneNumberTextController.text,
            dob: birthday,
            description: (bioTextController.text.isEmpty)
                ? "sao lai ep toi gioi thieu"
                : bioTextController.text);
        var response = await auth
            .updateProfile(request)
            .then((value) => Get.offAllNamed(AppRoutes.tabScreen));
      }
    }
  }
}
