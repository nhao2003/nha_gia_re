import 'package:flutter/material.dart';

import '../../../core/theme/text_styles.dart';

class Detail extends StatelessWidget {
  Detail({super.key, required this.iconAsset, required this.value});
  final String iconAsset;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Image.asset(
                  iconAsset,
                  width: 24,
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