import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/search/screens/result_page.dart';

class ResultArgScreen extends StatelessWidget {
  ResultArgScreen({super.key});

  String title = Get.arguments['title'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ResultPage(),
    );
  }
}
