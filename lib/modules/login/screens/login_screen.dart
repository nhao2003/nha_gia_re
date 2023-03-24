import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Login"),
      ),
    );
  }
}
