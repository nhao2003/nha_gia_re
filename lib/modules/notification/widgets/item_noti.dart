import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/notification.dart';
import 'package:nha_gia_re/data/repositories/notification_repository.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ItemNoti extends StatefulWidget {
  NotificationModel notiModel;

  ItemNoti({
    required this.notiModel,
    super.key,
  });

  @override
  State<ItemNoti> createState() => _ItemNotiState();
}

class _ItemNotiState extends State<ItemNoti> {
  double sizeImage = 80;
  NotificationRepository notiRepo = GetIt.instance<NotificationRepository>();
  Color getColorStatus() {
    switch (widget.notiModel.type) {
      case NotificationType.suggest:
        return AppColors.grey;
      case NotificationType.expirationWarning:
        return AppColors.primaryColor;
      case NotificationType.rejectPost:
        return AppColors.red;
      case NotificationType.acceptPost:
        return AppColors.green;
      case NotificationType.advertise:
        return const Color(0xff49454F);
    }
  }

  String getStatus() {
    switch (widget.notiModel.type) {
      case NotificationType.suggest:
        return "Có thể bạn qua tâm";
      case NotificationType.expirationWarning:
        return "Tin của bạn gần hết hạn";
      case NotificationType.rejectPost:
        return "Tin của bạn bị từ chối";
      case NotificationType.acceptPost:
        return "Tin của bạn đã được duyệt";
      case NotificationType.advertise:
        return "Quảng cáo dành cho bạn";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        widget.notiModel.isRead = true;
        debugPrint('test');
        await notiRepo.setIsReadNotification(widget.notiModel.id);
        setState(() {});
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                // delete task
                await notiRepo.deleteNotification(widget.notiModel.id);
              },
              icon: Icons.delete,
              backgroundColor: AppColors.red,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(bottom: 8),
          color: !widget.notiModel.isRead
              ? const Color.fromARGB(255, 250, 245, 227)
              : AppColors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image
              SizedBox(
                height: sizeImage,
                width: sizeImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl:
                    widget.notiModel.image!,
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/images/default_image.png",
                        fit: BoxFit.cover,
                      );
                    },
                    progressIndicatorBuilder: ( context, string, loadingProgress) {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.progress,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getStatus(),
                      style: AppTextStyles.roboto12semiBold
                          .copyWith(color: getColorStatus()),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.notiModel.title,
                      style: !widget.notiModel.isRead
                          ? AppTextStyles.roboto16Bold
                          : AppTextStyles.roboto16regular,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.notiModel.content,
                      style: AppTextStyles.roboto14regular.copyWith(
                        color: const Color(0xff49454F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
