import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/extensions/double_ex.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/utils/map_utils.dart';
import 'package:nha_gia_re/modules/chat/widgets/media_grid.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/message.dart';

class MessageRow extends StatelessWidget {
  final Message message;
  bool isNewest;
  final Function(Message message)? onLocationMessageTap;
  final Function(Message message)? onTextMessageTap;
  final Function(Message message, int index)? onMediaItemInMediaGridTap;

  MessageRow(
    this.message, {
    Key? key,
    this.onLocationMessageTap,
    this.onTextMessageTap,
    this.onMediaItemInMediaGridTap,
    this.isNewest = false,
  }) : super(key: key);

  Widget _buildContent() {
    if (message.text?.trim().isNotEmpty ?? false) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMine ? AppColors.primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          onTap: onTextMessageTap != null
              ? () => onTextMessageTap!(message)
              : null,
          child: Text(
            message.text ?? "NULL",
            style: AppTextStyles.roboto16regular,
          ),
        ),
      );
    }
    if (message.location != null) {
      return FutureBuilder(
          future: placemarkFromCoordinates(
              message.location!.latitude, message.location!.longitude),
          builder: (context, snapShot) {
            RxString title = "Vị trí không xác định".obs;
            if (snapShot.hasData) {
              final data = snapShot.data;
              if (data != null && data.isNotEmpty) {
                final place = data.first;
                title = MapUtils.buildAddressString(
                        name: place.name,
                        street: place.street,
                        administrativeArea: place.administrativeArea,
                        locality: place.locality,
                        country: place.country)
                    .obs;
              }
            }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: MapUtils.getStaticMapUrl(message.location!, 10),
                    ),
                  ),
                  ListTile(
                    title: Obx(() => Text(title.value)),
                    subtitle: const Text("Nhấn để xem vị trí trên bản đồ"),
                    onTap: onLocationMessageTap != null
                        ? () => onLocationMessageTap!(message)
                        : null,
                  ),
                ],
              ),
            );
          });
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment:
              message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              constraints: BoxConstraints(maxWidth: 75.0.wp),
              child: Column(
                crossAxisAlignment: message.isMine
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContent(),
                  if (message.images != null)
                    Column(
                      children: [
                        const SizedBox(height: 4),
                        MediaGrid(
                          message.images!,
                          onMediaItemInMediaGridTap:
                              onMediaItemInMediaGridTap != null
                                  ? (index) =>
                                      onMediaItemInMediaGridTap!(message, index)
                                  : null,
                        ),
                      ],
                    ),
                  const SizedBox(height: 4),
                  Text(
                    (isNewest && message.isMine)
                        ? (message.isRead ? "Đã xem" : "Đã gửi")
                        : DateFormat('HH:mm').format(message.sentAt),
                    style: TextStyle(fontSize: 12, color: AppColors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
