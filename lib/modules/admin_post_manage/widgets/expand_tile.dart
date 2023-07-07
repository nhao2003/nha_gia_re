import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';

class ExpandTile extends StatefulWidget {
  const ExpandTile({super.key});

  @override
  State<ExpandTile> createState() => _ExpandTileState();
}

class _ExpandTileState extends State<ExpandTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12.h)),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Container()),
    );
  }
}
