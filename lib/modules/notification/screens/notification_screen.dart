import 'package:flutter/material.dart';
import 'package:nha_gia_re/modules/notification/widgets/item_noti.dart';

import '../../../core/theme/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Thông báo"),
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return ItemNoti(
            colorStatus: const Color(0xff49454F),
            status: "Hiển thị đến 12:23 9/9/2023",
            title: "Trọ Quận Tân Bình",
            address: "449/58 Trường Chinh P14 Tân Bình HCM",
            urlImage:
                "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
          );
        },
      ),
    );
  }
}
