import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import '../search_controller.dart';
import '../widgets/my_search_delegate.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController searchController = Get.find<SearchController>();
  // search sreen
  late MySearchDelegate _delegate;

  @override
  void initState() {
    super.initState();
    _delegate = MySearchDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar search
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          searchController.sreenName,
          style:
              AppTextStyles.roboto16semiBold.copyWith(color: AppColors.black),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            color: AppColors.black,
            onPressed: () async {
              final String? selected = await showSearch<String>(
                context: context,
                delegate: _delegate,
              );
              if (mounted && selected != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You have selected the word: $selected'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
