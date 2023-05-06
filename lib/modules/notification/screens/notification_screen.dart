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
      body: ListView(
        children: [
          ItemNoti(
            colorStatus: AppColors.grey,
            status: "Có thể bạn quan tâm",
            title: "Trọ Quận Tân Bình",
            address: "449/58 Trường Chinh P14 Tân Bình HCM",
            urlImage:
                "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
          ),
          ItemNoti(
            colorStatus: AppColors.primaryColor,
            status: "Tin của bạn sẽ hết hạn sau 1 ngày nữa",
            title: "Trọ Quận Tân Bình",
            address: "449/58 Trường Chinh P14 Tân Bình HCM",
            urlImage:
                "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
          ),
          ItemNoti(
            colorStatus: AppColors.red,
            status: "Bị từ chối",
            title: "Trọ Quận Tân Bình",
            address: "449/58 Trường Chinh P14 Tân Bình HCM",
            urlImage:
                "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
          ),
          ItemNoti(
            colorStatus: AppColors.green,
            status: "Đã được duyệt",
            title: "Trọ Quận Tân Bình",
            address: "449/58 Trường Chinh P14 Tân Bình HCM",
            urlImage:
                "https://globalcastingresources.com/wp-content/uploads/2022/10/1664482232_How-much-does-the-anime-streaming-service-cost.jpg",
          ),
        ],
      ),
    );
  }
}
