import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem(
      {super.key,
      required this.title,
      required this.onPressed,
      this.icon,
      this.imageUrl});
  final String title;
  final Widget? icon;
  final String? imageUrl;
  final VoidCallback onPressed;
  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: widget.onPressed,
      child: InkWell(
        child: Column(children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              if (widget.imageUrl != null)
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl!),
                  radius: 20.0,
                )
              else
                Container(child: widget.icon),
              const SizedBox(
                width: 16,
              ),
              Text(
                widget.title,
                style: (widget.imageUrl == null)
                    ? AppTextStyles.roboto20regular
                    : AppTextStyles.roboto20Bold,
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Divider(
            color: AppColors.grey,
          ),
        ]),
      ),
    );
  }
}
