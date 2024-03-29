import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../core/extensions/color_ex.dart';
import '../../../core/theme/text_styles.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key, this.icon, required this.title, required this.onPressed});

  final Widget? icon;
  final String title;
  final VoidCallback onPressed;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: ZoomTapAnimation(
            child: ElevatedButton(
                onPressed: widget.onPressed,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(HexColor.fromHex('F5F5F5')),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.grey.shade300)))),
                child: widget.icon),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          widget.title,
          style: AppTextStyles.roboto16semiBold,
        )
      ],
    );
  }
}
