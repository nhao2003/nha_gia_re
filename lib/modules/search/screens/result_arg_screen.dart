import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/search/screens/result_page.dart';
import '../my_search_controller.dart';

class ResultArgScreen extends StatelessWidget {
  ResultArgScreen({super.key});

  final MySearchController searchController = Get.find<MySearchController>();
  String title = Get.arguments['title'];

  @override
  Widget build(BuildContext context) {
    searchController.setTypeResult(Get.arguments['type']);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ResultPage(),
    );
  }
}
