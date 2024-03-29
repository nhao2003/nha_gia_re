import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';

class StepperIdentify extends StatelessWidget {
  int value;
  StepperIdentify(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: value,
      lineLength: 100,
      lineSpace: 5,
      lineType: LineType.dotted,
      defaultLineColor: AppColors.grey,
      finishedLineColor: AppColors.primaryColor,
      activeStepTextColor: Colors.black87,
      finishedStepTextColor: Colors.black87,
      internalPadding: 2,
      stepRadius: 9,
      showLoadingAnimation: false,
      showStepBorder: false,
      steps: [
        EasyStep(
          customStep: CircleAvatar(
            radius: 9,
            backgroundColor:
                value >= 0 ? AppColors.primaryColor : Colors.black87,
            child: CircleAvatar(
              radius: 8,
              backgroundColor:
                  value >= 0 ? AppColors.primaryColor : Colors.white,
              child: const Icon(
                Icons.done,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          customTitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Giấy tờ tùy thân',
              textAlign: TextAlign.center,
              style: AppTextStyles.roboto12regular.copyWith(
                color: value >= 0 ? Colors.amber.shade700 : Colors.black87,
              ),
            ),
          ),
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 9,
            backgroundColor:
                value >= 1 ? AppColors.primaryColor : Colors.black87,
            child: CircleAvatar(
              radius: 8,
              backgroundColor:
                  value >= 1 ? AppColors.primaryColor : Colors.white,
              child: const Icon(
                Icons.done,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          customTitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Ảnh chân dung',
              textAlign: TextAlign.center,
              style: AppTextStyles.roboto12regular.copyWith(
                color: value >= 1 ? Colors.amber.shade700 : Colors.black87,
              ),
            ),
          ),
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 9,
            backgroundColor:
                value >= 2 ? AppColors.primaryColor : Colors.black87,
            child: CircleAvatar(
              radius: 8,
              backgroundColor:
                  value >= 2 ? AppColors.primaryColor : Colors.white,
              child: const Icon(
                Icons.done,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          customTitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Thông tin cá nhân',
              textAlign: TextAlign.center,
              style: AppTextStyles.roboto12regular.copyWith(
                color: value >= 2 ? Colors.amber.shade700 : Colors.black87,
              ),
            ),
          ),
        ),
      ],
      onStepReached: (index) => {},
    );
  }
}
