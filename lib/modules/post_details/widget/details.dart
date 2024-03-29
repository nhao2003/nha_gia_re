import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/theme/text_styles.dart';

class Detail extends StatelessWidget {
  Detail({super.key, required this.iconAsset, required this.value, this.icon});
  final String iconAsset;
  final String value;
  IoniconsData? icon;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        icon == null
            ? Image.asset(
                iconAsset,
                width: 24,
              )
            : Icon(
                icon,
                size: 24,
              ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              value,
              style: AppTextStyles.roboto14regular,
              maxLines: 2,
            )),
      ],
    );
  }
}
