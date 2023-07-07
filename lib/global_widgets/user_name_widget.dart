import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/text_styles.dart';
import '../core/values/assets_image.dart';

class UsernameWithTickLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double labelSize;
  const UsernameWithTickLabel(this.text, {this.style, this.labelSize = 16, super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        maxLines: 1,
        text: TextSpan(children: [
          TextSpan(
            text: text,
            style: style ??
                AppTextStyles.roboto16semiBold.copyWith(
                  color: AppColors.black,
                ),
          ),
          TextSpan(
            text: "  ",
            style: AppTextStyles.roboto16semiBold.copyWith(
              color: AppColors.black,
            ),
          ),
          WidgetSpan(
              child: SizedBox(
                  height: labelSize, width: labelSize, child: Image.asset(Assets.blueTick)))
        ]));
  }
}
