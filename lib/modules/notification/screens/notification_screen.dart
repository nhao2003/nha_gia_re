import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/notification.dart';
import 'package:nha_gia_re/modules/notification/notification_controller.dart';
import 'package:nha_gia_re/modules/notification/widgets/item_noti.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController _controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Thông báo"),
      ),
      body: FutureBuilder(
        future: _controller.notiRepo.fetchNotification(),
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
                  () => snapshot.data!.isEmpty
                      ? Center(
                          child: Text(
                            "Không có thông báo nào",
                            style: AppTextStyles.roboto20Bold
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, i) {
                            NotificationModel noti = snapshot.data![i];
                            return ItemNoti(notiModel: noti);
                          },
                        ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
