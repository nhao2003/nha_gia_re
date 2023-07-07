import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/modules/admin_verification/admin_verification_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/providers/remote/response/account_verification_requests.dart';

class UserVerificationScreen extends StatelessWidget {
  AccountVerificationResponse response;
  UserVerificationScreen(this.response, {super.key});
  TextEditingController messageController = TextEditingController();
  AdminVerificationController controller = Get.find();

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      barrierColor: const Color.fromARGB(0, 217, 11, 11),
      builder: (context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 500.h,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                  child: Column(children: [
                    Text(
                      "Từ chối xác nhận",
                      style: AppTextStyles.roboto20semiBold
                          .apply(color: AppColors.black),
                    ),
                    const SizedBox.square(
                      dimension: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      child: TextField(
                        controller: messageController,
                        onEditingComplete: () {},
                        minLines: 3,
                        maxLines: 5,
                        onChanged: (value) {},
                        onSubmitted: (value) {},
                        cursorColor: AppColors.backgroundColor,
                        keyboardType: TextInputType.multiline,
                        style: AppTextStyles.roboto16regular
                            .apply(color: AppColors.grey),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(6.h),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Nhập nội dung từ chối",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.gery2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.gery2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.gery2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox.square(
                      dimension: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 35.h,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                color: AppColors.secondary),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  controller.rejectInfo =
                                      messageController.text;
                                  controller.rejectRequest(response.id);
                                  Get.back();
                                  Get.back();
                                },
                                child: Text(
                                  "Hoàn thành",
                                  style: AppTextStyles.roboto16semiBold
                                      .apply(color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String formatTime(DateTime timestamp) {
    DateTime now = DateTime.now();
    DateTime msgTime = timestamp;
    if (now.year == msgTime.year &&
        now.month == msgTime.month &&
        now.day == msgTime.day &&
        now.day == msgTime.day) {
      return DateFormat.Hm().format(msgTime);
    } else if (now.year == msgTime.year &&
        now.month == msgTime.month &&
        now.day == msgTime.day &&
        now.day == msgTime.day + 1) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(msgTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(response.fullName),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: 150,
                      height: 200,
                      imageUrl: response.portraitImagePath,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/default_image.png",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Ảnh chân dung",
                    style: AppTextStyles.roboto18Bold,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        "Thông tin cá nhân",
                        style: AppTextStyles.roboto18Bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ten
                        Text(
                          "Họ và tên:  ${response.fullName}",
                          style: AppTextStyles.roboto16semiBold,
                        ),
                        const SizedBox(height: 10),
                        // gioi tinh
                        Text(
                          "Giới tính:  ${response.sex ? "Nam" : "Nữ"}",
                          style: AppTextStyles.roboto16semiBold,
                        ),
                        const SizedBox(height: 10),
                        // ngay sinh
                        Text(
                          "Ngày sinh:  ${formatTime(DateTime.parse(response.dob))}",
                          style: AppTextStyles.roboto16semiBold,
                        ),
                        const SizedBox(height: 10),
                        // so id
                        Text(
                          "Số căn cước công dân:  ${response.identityCardNo}",
                          style: AppTextStyles.roboto16semiBold,
                        ),
                        const SizedBox(height: 10),
                        // ngay phat
                        Text(
                          "Ngày cấp:  ${formatTime(response.identityCardIssuedDate)}",
                          style: AppTextStyles.roboto16semiBold,
                        ),
                        const SizedBox(height: 10),
                        // co quan ban hanh
                        Text(
                          "Cơ quan cấp:  ${response.issuedBy}",
                          style: AppTextStyles.roboto16semiBold,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        "Ảnh căn cước công dân mặt trước",
                        style: AppTextStyles.roboto18Bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 220,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: response.frontIdentityCardImageLink,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/default_image.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        "Ảnh căn cước công dân mặt sau",
                        style: AppTextStyles.roboto18Bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 220,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: response.backIdentityCardImageLink,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/default_image.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (response.rejectedInfo != null)
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          "Lý do từ chối",
                          style: AppTextStyles.roboto18Bold,
                        ),
                      ],
                    ),
                  if (response.rejectedInfo != null) const SizedBox(height: 10),
                  if (response.rejectedInfo != null)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ten
                          Text(
                            response.rejectedInfo!,
                            style: AppTextStyles.roboto16semiBold
                                .copyWith(color: AppColors.red),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _displayBottomSheet(context);
                  },
                  child: Container(
                    height: 35.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.h),
                        color: AppColors.white),
                    child: Center(
                      child: Text(
                        "Từ chối",
                        style: AppTextStyles.roboto16semiBold
                            .apply(color: AppColors.gery2),
                      ),
                    ),
                  ),
                ),
                SizedBox.square(
                  dimension: 20.h,
                ),
                GestureDetector(
                  child: Container(
                    height: 35.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.h),
                        color: AppColors.secondary),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          if (!controller.isExecute) {
                            controller.isExecute = true;
                            controller.approveRequest(response.id);
                            Get.back();
                          }
                        },
                        child: Text(
                          "Xác nhận",
                          style: AppTextStyles.roboto16semiBold
                              .apply(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
