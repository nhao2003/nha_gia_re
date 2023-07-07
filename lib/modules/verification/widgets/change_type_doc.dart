import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/data/enums/enums.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/values/assets_image.dart';
import '../verification_controller.dart';

class ChangeTypeDoc extends StatelessWidget {
  VerificationController verifyController;
  ChangeTypeDoc(this.verifyController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // icon
          Row(
            children: [
              Image.asset(
                Assets.id_card,
                height: 25,
                color: Colors.amber.shade800,
              ),
              const SizedBox(width: 10),
              Obx(
                () => Text(
                  verifyController.typeIndetificationDocument.value.toString(),
                  style: AppTextStyles.roboto14regular,
                ),
              ),
            ],
          ),

          // text
          TextButton(
            onPressed: () {
              //_controller.changeTypeIdentityDocuments();
              showChossTypeDialog(context);
            },
            child: Text(
              "Thay đổi",
              style: AppTextStyles.roboto14regular
                  .copyWith(color: Colors.amber.shade700),
            ),
          )
          // text
        ],
      ),
    );
  }

  showChossTypeDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        void changeType(int ind) {
          verifyController.selectedRadio = ind;
          if (ind == 0) {
            verifyController.changeTypeIdentityDocuments(
                TypeIndetificationDocument.chungMinhNhanDan);
          } else if (ind == 1) {
            verifyController.changeTypeIdentityDocuments(
                TypeIndetificationDocument.canCuocCongDan);
          } else {
            verifyController.changeTypeIdentityDocuments(
                TypeIndetificationDocument.hoChieu);
          }
          Navigator.pop(context);
        }

        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Loại giấy tờ",
                    style: AppTextStyles.roboto20Bold,
                  ),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                        value: 0,
                        groupValue: verifyController.selectedRadio,
                        contentPadding:
                            const EdgeInsets.only(left: 0, top: 0, bottom: 0),
                        title: Text(
                          "Chứng minh nhân dân",
                          style: AppTextStyles.roboto14regular,
                        ),
                        onChanged: (ind) {
                          changeType(ind!);
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                        value: 1,
                        groupValue: verifyController.selectedRadio,
                        contentPadding: const EdgeInsets.only(left: 0),
                        title: Text(
                          "Căn cước công dân",
                          style: AppTextStyles.roboto14regular,
                        ),
                        onChanged: (ind) {
                          changeType(ind!);
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: RadioListTile(
                        value: 2,
                        groupValue: verifyController.selectedRadio,
                        contentPadding: const EdgeInsets.only(left: 0),
                        title: Text(
                          "Hộ chiếu",
                          style: AppTextStyles.roboto14regular,
                        ),
                        onChanged: (ind) {
                          changeType(ind!);
                          setState(() {});
                        },
                      ),
                    ),
                  ]),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
