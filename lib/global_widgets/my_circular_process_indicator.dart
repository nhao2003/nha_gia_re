import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../core/values/assets_image.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  final double height;
  final double width;

  const MyCircularProgressIndicator(
      {this.height = 80, this.width = 80, super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(Assets.loading, height: height, width: width);
  }
}
