import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/repositories/auth_repository.dart';

import '../../../core/extensions/color_ex.dart';
import '../../../core/theme/text_styles.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, this.icon, required this.title});

  final Widget? icon;
  final String title;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
              Container(
                width: 64,
                height: 64,
                child: ElevatedButton(
                  onPressed: (){ AuthRepository().signOut(); },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(HexColor.fromHex('F5F5F5')),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.grey.shade300)
                      )
                    )
                  ), 
                  child: widget.icon
                ),
              ),
              const SizedBox(height: 16,),
              Text(widget.title, style: AppTextStyles.roboto16semiBold,)
            ],
            ),
    );
  }
}