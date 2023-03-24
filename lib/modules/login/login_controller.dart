import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  var email;
  var password;

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return (value!.isEmpty  || (value.isNotEmpty && !regex.hasMatch(value)))
        ? 'Invalid email address'.tr
        : null;
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
}
