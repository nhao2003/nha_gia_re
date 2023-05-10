import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/services/upload_avatar_service.dart';
import 'package:nha_gia_re/modules/user_profile/user_profile_controller.dart';
import 'package:nha_gia_re/modules/user_profile/widgets/user_image_picker.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProfileController _controller = Get.find<UserProfileController>();
    _controller.init(Get.arguments);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật thông tin"),
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
                    decoration: const InputDecoration(
                        hintText: 'Họ và tên',
                        labelText: 'Họ và tên',
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
                    decoration: const InputDecoration(
                        hintText: 'Số điện thoại',
                        labelText: 'Số điện thoại',
                        border: OutlineInputBorder()),
                    validator: _controller.validateTextField,
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
                            "Nam",
                            style: AppTextStyles.roboto16regular,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Row(
                        children: [
                          Obx(() => Radio(
                              value: "female",
                              groupValue: _controller.gender.value,
                              onChanged: (value) =>
                                  _controller.gender.value = value.toString())),
                          Text(
                            "Nữ",
                            style: AppTextStyles.roboto16regular,
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
                      controller: _controller.birthDayTextController,
                      readOnly: true,
                      decoration: const InputDecoration(
                          hintText: 'Ngày sinh',
                          labelText: 'Ngày sinh',
                          border: OutlineInputBorder()),
                      validator: _controller.validateTextField,
                      onTap: _controller.handleDatePicker),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _controller.bioTextController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                        hintText: 'Giới thiệu về bản thân',
                        alignLabelWithHint: true,
                        labelText: 'Giới thiệu',
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
                          child: const Text(
                            "Lưu",
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
