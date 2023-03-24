import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.find<HomeController>();
    return const Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
