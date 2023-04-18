import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:intl/intl.dart';

class RangeSliderCustom extends StatefulWidget {
  @override
  State<RangeSliderCustom> createState() => _RangeSliderCustomState();
}

class _RangeSliderCustomState extends State<RangeSliderCustom> {
  double LOWER = 0;
  double UPPER = 30000000000;
  double lowerValue = 0;
  double upperValue = 30000000000;

  var formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'Giá từ ', style: nomalText),
            TextSpan(
                text: '${formatter.format(lowerValue.toInt())}đ',
                style: highlightText),
            TextSpan(text: ' đến ', style: nomalText),
            TextSpan(
                text: '${formatter.format(upperValue.toInt())}đ',
                style: highlightText),
          ]),
        ),
        FlutterSlider(
          values: [lowerValue, upperValue],
          rangeSlider: true,
          /* ignoreSteps: [
            FlutterSliderIgnoreSteps(from: 8000, to: 12000),
            FlutterSliderIgnoreSteps(from: 18000, to: 22000),
          ], */
          max: UPPER,
          min: LOWER,
          step: const FlutterSliderStep(step: 100000000),
          jump: true,
          trackBar: FlutterSliderTrackBar(
            activeTrackBarHeight: 5,
            activeTrackBar: BoxDecoration(color: AppColors.primaryColor),
            inactiveTrackBarHeight: 5,
            inactiveTrackBar: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.backgroundColor,
              border: Border.all(width: 0.5, color: AppColors.grey),
            ),
          ),
          tooltip: FlutterSliderTooltip(
            disabled: true,
          ),
          handler: handlerStyle,
          rightHandler: handlerStyle,
          disabled: false,
          onDragging: (handlerIndex, lower, upper) {
            lowerValue = lower;
            upperValue = upper;
            setState(() {});
          },
        ),
      ],
    );
  }

  TextStyle nomalText = AppTextStyles.roboto14regular.copyWith(
    color: AppColors.black,
  );
  TextStyle highlightText = AppTextStyles.roboto14semiBold.copyWith(
    color: AppColors.primaryColor,
  );

  FlutterSliderHandler handlerStyle = FlutterSliderHandler(
    decoration: const BoxDecoration(),
    child: Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(width: 1, color: AppColors.grey),
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}
