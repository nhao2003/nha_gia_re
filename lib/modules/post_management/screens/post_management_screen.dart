import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/post_management/post_management_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/list_posts_expried.dart';
import '../widgets/list_posts_hided.dart';
import '../widgets/list_posts_pendding.dart';
import '../widgets/list_posts_posted.dart';
import '../widgets/list_posts_reject.dart';

class PostManagementScreen extends StatefulWidget {
  PostManagementScreen({super.key});

  @override
  State<PostManagementScreen> createState() => _PostManagementScreenState();
}

class _PostManagementScreenState extends State<PostManagementScreen> {
  final PostManagementController controller =
      Get.find<PostManagementController>();

  @override
  void initState() {
    controller.getPostsInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.typePosts.length,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text('Posts Management'.tr),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: ColoredBox(
                  color: AppColors.white,
                  child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor:
                          const Color.fromARGB(206, 73, 69, 79),
                      indicator: UnderlineTabIndicator(
                        borderSide:
                            BorderSide(color: AppColors.primaryColor, width: 2),
                      ),
                      dividerColor: AppColors.primaryColor,
                      labelColor: AppColors.black,
                      tabs: controller.typePosts.map((e) {
                        return Tab(
                          child: Text(e),
                        );
                      }).toList()),
                )),
          ),
          body: TabBarView(
            children: <Widget>[
              ListPostsPosted(),
              ListPostsPendding(),
              ListPostsReject(),
              ListPostsHided(),
              ListPostsExpried(),
            ],
          )),
    );
  }
}
