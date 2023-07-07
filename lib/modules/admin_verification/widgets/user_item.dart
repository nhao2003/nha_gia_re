import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/theme/text_styles.dart';
import '../../../data/providers/remote/response/account_verification_requests.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  AccountVerificationResponse response;
  UserItem(this.response, {super.key});

  String formatTime(DateTime timestamp) {
    DateTime now = DateTime.now();
    DateTime msgTime = timestamp;
    if (now.year == msgTime.year &&
        now.month == msgTime.month &&
        now.day == msgTime.day &&
        now.day == msgTime.day) {
      return DateFormat.Hm().format(msgTime);
    } else if (now.year == msgTime.year &&
        now.month == msgTime.month &&
        now.day == msgTime.day &&
        now.day == msgTime.day + 1) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(msgTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          //controller.navigateToDetailSceen(posts[index]);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.h), color: Colors.white60),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),
            // horizontalTitleGap: 6,
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                width: 60,
                height: 70,
                imageUrl: response.portraitImagePath,
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/default_image.png",
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  response.fullName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyles.roboto16semiBold,
                ),
                const SizedBox.square(
                  dimension: 10,
                ),
                Text(response.identityCardNo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.roboto12regular),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatTime(response.requestDate),
                  style: AppTextStyles.roboto12regular,
                ),
                const Icon(Ionicons.arrow_forward_circle_outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
