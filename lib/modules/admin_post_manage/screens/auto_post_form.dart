import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nha_gia_re/modules/admin_post_manage/admin_post_controller.dart';
import 'package:nha_gia_re/modules/admin_post_manage/widgets/text_field.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class AuToFormScreen extends StatefulWidget {
  const AuToFormScreen({super.key});

  @override
  State<AuToFormScreen> createState() => _AuToFormScreenState();
}

class _AuToFormScreenState extends State<AuToFormScreen> {
  TextEditingController editTime = TextEditingController();
  TextEditingController requestTime = TextEditingController();
  TextEditingController maxNumberOfPost = TextEditingController();
  TextEditingController expiseTime = TextEditingController();
  DateTime? selectedDate;
  void _showTimeDialog() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final AdminPostController controller = Get.find<AdminPostController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Đăng tin tự động"),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Form(
            key: controller.formkey,
            child: ListView(
              children: [
                Text(
                  "Số lần tin chỉnh sửa tối đa",
                  style: AppTextStyles.roboto16semiBold,
                ),
                AutoTextField(controller: editTime, hint: "Ví dụ: 1"),
                Text(
                  "Số lần yêu cầu duyệt tối đa",
                  style: AppTextStyles.roboto16semiBold,
                ),
                AutoTextField(controller: requestTime, hint: "Ví dụ: 1"),
                Text(
                  "Số tin tối đa được đăng trong tháng",
                  style: AppTextStyles.roboto16semiBold,
                ),
                AutoTextField(controller: maxNumberOfPost, hint: "Ví dụ: 1"),
                Text(
                  "Số lần gia hạn tối đa",
                  style: AppTextStyles.roboto16semiBold,
                ),
                AutoTextField(controller: expiseTime, hint: "Ví dụ: 1"),
                Text(
                  "Thời gian tạo tin tối thiểu",
                  style: AppTextStyles.roboto16semiBold,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _showTimeDialog();
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 1, color: AppColors.gery2),
                    ),
                    child: SizedBox(
                      child: Text(selectedDate != null
                          ? controller.formatTime(selectedDate!)
                          : "Chọn thời gian"),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: controller.handleEditAutoForm(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      color: AppColors.primaryColor,
                    ),
                    child: SizedBox(
                        width: double.maxFinite,
                        height: 30.h,
                        child: controller.isEditing
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(1),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                "Đăng tin",
                                style: AppTextStyles.roboto16semiBold
                                    .copyWith(color: Colors.white),
                              ))),
                  ),
                )
              ],
            )),
      )),
    );
  }
}
