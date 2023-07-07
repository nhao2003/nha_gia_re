import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class AutoTextField extends StatelessWidget {
  const AutoTextField(
      {super.key,
      required this.controller,
      required this.hint,
      this.validator});
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          maxLines: 1,
          cursorColor: AppColors.backgroundColor,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          style: AppTextStyles.roboto16regular.apply(color: AppColors.black),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(15),
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gery2),
              borderRadius: BorderRadius.circular(5),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gery2),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          validator: validator,
        ),
        SizedBox.fromSize(
          size: const Size(10, 10),
        ),
      ],
    );
  }
}
