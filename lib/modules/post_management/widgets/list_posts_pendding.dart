import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';

import 'item_post.dart';

class ListPostsPendding extends StatelessWidget {
  const ListPostsPendding({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return ItemPost(
          colorStatus: AppColors.grey,
          status: "Đang chờ duyệt",
          title: "Trọ Quận Tân Bình",
          address: "449/58 Trường Chinh P14 Tân Bình HCM",
          urlImage:
              "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
          funcs: const [
            "Chỉnh sửa",
            "Xóa tin",
          ],
          iconFuncs: const [
            Icons.edit,
            Icons.delete_outline,
          ],
        );
      },
    );
    ;
  }
}
