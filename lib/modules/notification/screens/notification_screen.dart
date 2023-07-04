import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/notification/notification_controller.dart';
import 'package:nha_gia_re/modules/notification/widgets/item_noti.dart';

import '../../../core/theme/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController _controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _controller.init(),
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
              return Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.primaryColor,
                    title: const Text("Thông báo"),
                  ),
                  body: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: _controller.notifications.length,
                      itemBuilder: (context, index) {
                        return ItemNoti(
                          colorStatus: _controller.notifications[index].type.statusColor(),
                          status:
                              _controller.notifications[index].type.toString().tr,
                          title: _controller.notifications[index].title,
                          content: _controller.notifications[index].content,
                          urlImage: _controller.notifications[index].image!,
                        );
                      }));
            }
          }
        });
  }
}
