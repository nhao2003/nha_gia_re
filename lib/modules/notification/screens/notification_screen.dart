import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/models/notification.dart';
import 'package:nha_gia_re/modules/notification/notification_controller.dart';
import 'package:nha_gia_re/modules/notification/widgets/item_noti.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController _controller = Get.find<NotificationController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Thông báo"),
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, i) {
                    NotificationModel noti = snapshot.data![i];
                    return ItemNoti(notiModel: noti);
                  },
                ),
              );
            }
          }
        },
      ),
    );
    ;
  }
}
