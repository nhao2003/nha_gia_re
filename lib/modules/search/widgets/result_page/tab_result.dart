import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/modules/search/widgets/result_page/related_list.dart';
import '../../../../core/theme/app_colors.dart';

class TabResult extends StatelessWidget {
  const TabResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.primaryColor,
              tabs: const [
                Tab(
                  text: "Liên quan",
                ),
                Tab(
                  text: "Tin mới nhất",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  RelatedList(OrderBy.priceAsc),
                  RelatedList(OrderBy.createdAtDesc),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
