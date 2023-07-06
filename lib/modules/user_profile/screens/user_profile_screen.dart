import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/user_profile/user_profile_controller.dart';
import 'package:nha_gia_re/modules/user_profile/widgets/user_image_picker.dart';
import 'package:nha_gia_re/routers/app_routes.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileController _controller = Get.find<UserProfileController>();
    final TextEditingController addressController = TextEditingController();
    _controller.init(Get.arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update information'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _controller.userProfileFormKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(() => UserImagePicker(_controller.handelUploadAvatar,
                      _controller.isUploadAvatar.value, _controller.avatarUrl)),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _controller.fullNameTextController,
                    decoration:  InputDecoration(
                        hintText: 'Full name'.tr,
                        labelText: 'Full name'.tr,
                        border: OutlineInputBorder()),
                    validator: _controller.validateTextField,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _controller.phoneNumberTextController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        hintText: 'Phone number'.tr,
                        labelText: 'Phone number'.tr,
                        border: OutlineInputBorder()),
                    validator: _controller.validateTextField,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onTap: () async {
                      addressController.text = await Get.toNamed(AppRoutes.address)!.then((value) => value.toString());
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be empty.'.tr;
                      }
                      return null;
                    },
                    readOnly: true,
                    controller: addressController,
                    enabled: true,
                    decoration: InputDecoration(
                      hintText: 'Address'.tr,
                      hintStyle: AppTextStyles.roboto16regular
                          .copyWith(color: AppColors.grey),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          borderSide: const BorderSide(color: Colors.grey)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Obx(() => Radio(
                              value: "male",
                              groupValue: _controller.gender.value,
                              onChanged: (value) =>
                                  _controller.gender.value = value.toString())),
                          Text(
                            'Male'.tr,
                            style: AppTextStyles.roboto16regular,
                          ),
                        ],
                      ),
                      const SizedBox(width: 50),
                      Row(
                        children: [
                          Obx(() => Radio(
                              value: "female",
                              groupValue: _controller.gender.value,
                              onChanged: (value) =>
                                  _controller.gender.value = value.toString())),
                          Text(
                            'Female'.tr,
                            style: AppTextStyles.roboto16regular,
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
                      controller: _controller.birthDayTextController,
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: 'Date of birth'.tr,
                          labelText: 'Date of birth'.tr,
                          border: OutlineInputBorder()),
                      validator: _controller.validateTextField,
                      onTap: _controller.handleDatePicker),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _controller.bioTextController,
                    maxLines: 6,
                    decoration:  InputDecoration(
                        hintText: 'Write something about you'.tr,
                        alignLabelWithHint: true,
                        labelText: 'Bio'.tr,
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: _controller.handleSubmit,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: Text(
                            "Save".tr,
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
