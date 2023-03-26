import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../search_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final SearchController searchController = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("search"),
      ),
    );
  }
}
