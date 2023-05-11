import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/enums/enums.dart';

class ItemPost extends StatefulWidget {
  PostStatusMana statusCode;
  String status;
  String title;
  String address;
  String urlImage;
  List<String> funcs;
  List<IconData> iconFuncs;

  ItemPost({
    required this.statusCode,
    required this.status,
    required this.title,
    required this.address,
    required this.urlImage,
    required this.funcs,
    required this.iconFuncs,
    super.key,
  });

  @override
  State<ItemPost> createState() => _ItemPostState();
}

class _ItemPostState extends State<ItemPost> {
  double sizeImage = 80;

  int selectedMenu = 0;
  Color getColorStatus() {
    switch (widget.statusCode) {
      case PostStatusMana.approved:
        return const Color(0xff49454F);
      case PostStatusMana.pending:
        return AppColors.grey;
      case PostStatusMana.rejected:
        return AppColors.red;
      case PostStatusMana.hided:
        return AppColors.grey;
      case PostStatusMana.expired:
        return AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
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
                            .copyWith(color: getColorStatus()),
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
                // column text
                const SizedBox(width: 8),
              ],
            ),
          ),
          // more icon
          PopupMenuButton<int>(
            initialValue: selectedMenu,
            // Callback that sets the selected popup menu item.
            onSelected: (int item) {
              setState(() {
                selectedMenu = item;
              });
            },
            itemBuilder: (BuildContext context) =>
                widget.funcs.asMap().entries.map(
              (e) {
                int i = e.key;
                String val = e.value;
                return PopupMenuItem<int>(
                  value: i,
                  child: Row(
                    children: [
                      Icon(widget.iconFuncs[i]),
                      const SizedBox(width: 15),
                      Text(val),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
