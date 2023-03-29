import 'package:flutter/material.dart';
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
                  Container(
                    color: AppColors.blue,
                    child: const Center(
                      child: Text("Lien quan"),
                    ),
                  ),
                  Container(
                    color: AppColors.green,
                    child: const Center(
                      child: Text("Tin mới nhất"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
