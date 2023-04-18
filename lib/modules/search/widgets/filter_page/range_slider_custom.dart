import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/app_values.dart';

class RangeSliderCustom extends StatelessWidget {
  String title;
  String unit;
  double LOWER;
  double UPPER;
  RxDouble lowerValue;
  RxDouble upperValue;
  double stepValue;
  Function onChangeValue;
  RangeSliderCustom({
    required this.title,
    required this.unit,
    required this.LOWER,
    required this.UPPER,
    required this.lowerValue,
    required this.upperValue,
    required this.stepValue,
    required this.onChangeValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => RichText(
              text: TextSpan(children: [
                TextSpan(text: title, style: nomalText),
                TextSpan(
                    text:
                        '${FormatNum.formatter.format(lowerValue.value.toInt())}$unit',
                    style: highlightText),
                TextSpan(text: ' đến ', style: nomalText),
                TextSpan(
                    text:
                        '${FormatNum.formatter.format(upperValue.value.toInt())}$unit',
                    style: highlightText),
              ]),
            ),
          ),
        ),
        Obx(
          () => FlutterSlider(
            values: [lowerValue.value, upperValue.value],
            rangeSlider: true,
            /* ignoreSteps: [
                    FlutterSliderIgnoreSteps(from: 8000, to: 12000),
                    FlutterSliderIgnoreSteps(from: 18000, to: 22000),
                  ], */
            max: UPPER,
            min: LOWER,
            step: FlutterSliderStep(step: stepValue),
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
              onChangeValue(lower, upper);
            },
          ),
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
