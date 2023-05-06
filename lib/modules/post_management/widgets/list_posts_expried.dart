import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'item_post.dart';

class ListPostsExpried extends StatelessWidget {
  const ListPostsExpried({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return ItemPost(
          colorStatus: AppColors.primaryColor,
          status: "Hiển thị đến 12:23 9/9/2023",
          title: "Tin đã hết hạn",
          address: "449/58 Trường Chinh P14 Tân Bình HCM",
          urlImage:
              "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
          funcs: const [
            "Xóa tin",
            "Gia hạn",
          ],
          iconFuncs: const [
            Icons.delete_outline,
            Icons.timer_outlined,
          ],
        );
      },
    );
    ;
  }
}
