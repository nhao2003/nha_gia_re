import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/models/province.dart';
import 'package:nha_gia_re/modules/post/property_controller.dart';

class PostAddressScreen extends StatefulWidget {
  const PostAddressScreen({Key? key}) : super(key: key);

  @override
  State<PostAddressScreen> createState() => _PostAddressScreenState();
}

class _PostAddressScreenState extends State<PostAddressScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn địa chỉ", style: AppTextStyles.roboto16regular,),
        backgroundColor: AppColors.primaryColor,
      ),
      body: GetBuilder<PropertyController>(builder: (controller){
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
                        borderSide:const BorderSide(color: Colors.black)
                    ),
                    hintText: "Tỉnh/ thành phố",
                  ),
                  items: controller.provinceList.map((value) {
                    return DropdownMenuItem<Province?>(
                      value: value,  // ensure this is unique
                      child: value == null ? const Text("Chọn tỉnh, thành phố ") : Text(value.name != null ? value.name.toString() : "Chọn tỉnh, thành phố"),
                    );
                  }).toList(),
                  onChanged:(code){
                    controller.setProvince(code);
                  },
                  validator: (value){
                    if(value == null){
                      return "Vui lòng chọn tỉnh, thành phố";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h,),
                DropdownButtonFormField(
                  value: controller.selectedDistrict,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        borderSide:const BorderSide(color: Colors.black)
                    ),
                    hintText: "Quận/ huyện",
                  ),
                  items: controller.districtsList.map((value){
                    return DropdownMenuItem(value: value, child: value == null ? const Text("Chọn quận, huyện") : Text(value.name != null ? value.name.toString() : "Chọn quận, huyện"),);
                  }).toList(),
                  onChanged:(code){
                      print("Change district");
                      controller.setDistrict(code);
                  },
                  validator: (value){
                    if(value == null){
                      return "Vui lòng chọn quận, huyện";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h,),
                DropdownButtonFormField(
                  value: controller.selectedWard,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        borderSide:const BorderSide(color: Colors.black)
                    ),
                  ),
                  hint: Text("Phường/ xã"),
                  items: controller.wardsList.map((value){
                    return DropdownMenuItem(value: value, child: value != null ? Text(value.name != null ? value.name.toString() : "Chọn phường, xã") : const Text(""),);
                  }).toList(),
                  onChanged:(value){
                    controller.setWards(value);
                  },
                  validator: (value){
                    if(value == null){
                      return "Vui lòng chọn phường, xã";
                    }
                    return null;
                  },
                ),
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      print("Press on submit address");
                      controller.setAddress();
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical:5.h),
                    margin: EdgeInsets.symmetric( vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      color: AppColors.primaryColor,
                      boxShadow: [
                        BoxShadow( spreadRadius: 1, blurRadius: 2.3, color: AppColors.backgroundColor)
                      ]
                    ),
                    child: SizedBox(width: double.maxFinite,
                        height: 30.h,
                        child: Center(child: Text("Hoàn thành", style: AppTextStyles.roboto20semiBold.copyWith(color: Colors.white),))
                    ),
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


