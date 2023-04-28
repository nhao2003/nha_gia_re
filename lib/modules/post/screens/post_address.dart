import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/models/province.dart';
import 'package:nha_gia_re/modules/post/property_controller.dart';
import 'package:nha_gia_re/modules/post/screens/post_screen.dart';

class PostAddressScreen extends StatelessWidget {
  const PostAddressScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chọn địa chỉ",
          style: AppTextStyles.roboto16regular,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: GetBuilder<PropertyController>(
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  DropdownButtonFormField(
                    value: controller.selectedProvince,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          borderSide: const BorderSide(color: Colors.black)),
                    ),
                    hint: Text("Tỉnh/ thành phố"),
                    items: controller.provinceList.map((value) {
                      return DropdownMenuItem<Province>(
                        value: value,
                        child: Text(value.name.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.setProvince(value!);
                      print(value.name);
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Vui lòng chọn tỉnh, thành phố";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DropdownButtonFormField(
                    value: controller.selectedDistricts,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          borderSide: const BorderSide(color: Colors.black)),
                    ),
                    hint: Text("Quận/ huyện"),
                    items: controller.districtsList.map((value) {
                      return DropdownMenuItem<Districts>(
                        value: value,
                        child: Text(value.name.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      controller.setDistrict(value);
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Vui lòng chọn quận, huyện";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DropdownButtonFormField(
                    value: controller.selectedWards,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.r)),
                          borderSide: const BorderSide(color: Colors.black)),
                    ),
                    hint: Text("Phường/ xã"),
                    items: controller.wardsList.map((value) {
                      return DropdownMenuItem<Wards>(
                        value: value,
                        child: Text(value.name.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      controller.setWards(value);
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Vui lòng chọn phường, xã";
                      }
                      return null;
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        controller.setAddress();
                        Get.to(MyCustomForm());
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.h),
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 2.3,
                                color: AppColors.backgroundColor)
                          ]),
                      child: SizedBox(
                          width: double.maxFinite,
                          height: 20.h,
                          child: Center(
                              child: Text(
                            "Hoàn thành",
                            style: AppTextStyles.roboto20semiBold
                                .copyWith(color: Colors.white),
                          ))),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
