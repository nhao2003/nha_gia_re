import 'package:flutter/cupertino.dart';

import '../../../core/theme/app_colors.dart';

class DiscountLabel extends StatelessWidget {
  final String text;

  const DiscountLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
          color: AppColors.red.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        text,
        style: TextStyle(color: AppColors.red),
      ),
    );
  }
}
