import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';
import 'package:nha_gia_re/data/repositories/user_repository.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/text_styles.dart';
import '../core/values/assets_image.dart';

class UsernameWithTickLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double labelSize;
  final String uid;
  UsernameWithTickLabel(this.text,
      {this.style, this.labelSize = 16, super.key, required this.uid});

  final UserRepository userRepo = GetIt.instance<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return RichText(
        maxLines: 1,
        text: TextSpan(children: [
          TextSpan(
            text: text,
            style: style ??
                AppTextStyles.roboto16semiBold.copyWith(
                  color: AppColors.black,
                ),
          ),
          TextSpan(
            text: "  ",
            style: AppTextStyles.roboto16semiBold.copyWith(
              color: AppColors.black,
            ),
          ),
          WidgetSpan(
              child: SizedBox(
                  height: labelSize,
                  width: labelSize,
                  child: FutureBuilder(
                    future: userRepo.isVerifiedBadge(uid),
                    builder: (context,snapshot) {
                      if(!snapshot.hasData)
                      {
                        return const CircularProgressIndicator();
                      }
                      else
                      {
                        if(snapshot.data == true)
                        {
                          return Image.asset(Assets.blueTick);
                        }
                        else
                        {
                          return const Text(' ');
                        }
                      }
                  },)
                  ))
        ]));
  }
}
