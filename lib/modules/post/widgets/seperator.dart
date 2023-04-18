import 'package:flutter/cupertino.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';

class Seperator extends StatelessWidget {
  final double height;
  const Seperator({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color:AppColors.backgroundColor,
      ),
    );
  }
}
