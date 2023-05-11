import 'package:flutter/material.dart';
import 'package:nha_gia_re/modules/post_management/widgets/item_post.dart';
import '../../../data/enums/enums.dart';

class ListPostsPosted extends StatelessWidget {
  const ListPostsPosted({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return ItemPost(
          statusCode: PostStatusMana.approved,
          status: "Hiển thị đến 12:23 9/9/2023",
          title: "Trọ Quận Tân Bình",
          address: "449/58 Trường Chinh P14 Tân Bình HCM",
          urlImage:
              "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
          funcs: const [
            "Ẩn tin",
            "Chỉnh sửa",
            "Xóa tin",
            "Gia hạn",
          ],
          iconFuncs: const [
            Icons.remove_red_eye_outlined,
            Icons.edit,
            Icons.delete_outline,
            Icons.timer_outlined,
          ],
        );
      },
    );
  }
}
