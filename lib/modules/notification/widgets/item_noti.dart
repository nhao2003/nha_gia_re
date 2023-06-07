import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class ItemNoti extends StatefulWidget {
  Color colorStatus;
  String status;
  String title;
  String address;
  String urlImage;

  ItemNoti({
    required this.colorStatus,
    required this.status,
    required this.title,
    required this.address,
    required this.urlImage,
    super.key,
  });

  @override
  State<ItemNoti> createState() => _ItemNotiState();
}

class _ItemNotiState extends State<ItemNoti> {
  double sizeImage = 80;

  int selectedMenu = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          SizedBox(
            height: sizeImage,
            width: sizeImage,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.urlImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/default_image.png",
                    fit: BoxFit.cover,
                  );
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
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
                  widget.status,
                  style: AppTextStyles.roboto12semiBold
                      .copyWith(color: widget.colorStatus),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.title,
                  style: AppTextStyles.roboto16regular,
                ),
                const SizedBox(height: 5),
                Text(widget.address,
                    style: AppTextStyles.roboto14regular.copyWith(
                      color: const Color(0xff49454F),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
