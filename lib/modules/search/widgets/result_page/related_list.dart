import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/services/search_service.dart';
import 'package:nha_gia_re/modules/search/widgets/result_page/item_product.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/models/properties/post.dart';
import '../../my_search_controller.dart';

class RelatedList extends StatefulWidget {
  OrderBy orderBy;
  RelatedList(this.orderBy, {super.key});

  @override
  State<RelatedList> createState() => _RelatedListState();
}

class _RelatedListState extends State<RelatedList> {
  final MySearchController searchController = Get.find<MySearchController>();

  @override
  void initState() {
    SearchService.instance.setOrderBy(widget.orderBy);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchController.initPosts(widget.orderBy),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: Text('An error occured'),
            );
          } else {
            return Container(
              color: AppColors.backgroundColor,
              child: Obx(
                () => searchController.searchPosts.isEmpty
                    ? Center(
                        child: Text(
                          "Không có sản phẩm nào",
                          style: AppTextStyles.roboto20Bold
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      )
                    : ListView.builder(
                        itemCount: searchController.searchPosts.length,
                        itemBuilder: (_, i) {
                          Post prod = searchController.searchPosts[i];
                          return ItemProduct(
                            post: prod,
                            isFavourited: false,
                            onTap: searchController.navigateToDetailSceen,
                          );
                        },
                      ),
              ),
            );
          }
        }
      },
    );
  }
}
