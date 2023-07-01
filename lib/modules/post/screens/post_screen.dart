import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/services/validate_service.dart';
import 'package:nha_gia_re/modules/post/property_controller.dart';
import 'package:nha_gia_re/modules/post/screens/post_address.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:nha_gia_re/modules/post/widgets/check_field.dart';
import 'package:nha_gia_re/modules/post/widgets/dropdownfied.dart';
import 'package:nha_gia_re/modules/post/widgets/seperator.dart';
import 'package:nha_gia_re/modules/post/widgets/textformfield.dart';
import '../../../data/enums/enums.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  late String? selectedValue;
  Future<void> _loadResource() async {
    await Get.find<PropertyController>().getProvince();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
  }

  void _showPicker(context, PropertyController controller) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  controller.imgFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Camera"),
                onTap: () {
                  controller.imgFromCamera();
                  Get.back();
                },
              )
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(411, 683));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Đăng tin"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: GetBuilder<PropertyController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.r)),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                        ),
                        value: controller.selectedPropertyType,
                        hint: const Text("Chọn loại bất động sản"),
                        items: controller.propertyMap.entries.map((entry) {
                          return DropdownMenuItem(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.setVisibility(value);
                          }
                        },
                        onSaved: (value) {
                          if (value == null) return;
                          print("Save DropDown Fied" + value.toString());
                        },
                      ),
                    ),
                    Visibility(
                      visible: controller.selectedPropertyType !=
                                  PropertyType.motel &&
                              controller.selectedPropertyType != null
                          ? true
                          : false,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.setWork(true);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.h,
                                  vertical: 10.w,
                                ),
                                decoration: BoxDecoration(
                                    color: controller.isSale == true
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(
                                        color: Colors.black, width: 0.6.w)),
                                child: Text(
                                  "Cần bán",
                                  style: AppTextStyles.roboto14semiBold
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.setWork(false);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.h,
                                  vertical: 10.w,
                                ),
                                decoration: BoxDecoration(
                                    color: controller.isSale == false
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(
                                        color: Colors.black, width: 0.6.w)),
                                child: Text(
                                  "Cho thuê",
                                  style: AppTextStyles.roboto14semiBold
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Visibility(
                        visible: controller.selectedPropertyType != null
                            ? true
                            : false,
                        child: Column(children: [
                          const Seperator(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bạn là",
                                  style: AppTextStyles.roboto20semiBold,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Cá nhân/ Môi giới",
                                  style: AppTextStyles.roboto12regular,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.setRole(true);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.h,
                                          vertical: 10.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: controller.isPersonal == true
                                              ? AppColors.secondary
                                              : AppColors.backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Text(
                                          "Cá nhân",
                                          style: AppTextStyles.roboto14semiBold
                                              .copyWith(
                                                  color: controller
                                                              .isPersonal ==
                                                          true
                                                      ? AppColors.primaryColor
                                                      : AppColors.gery2),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.setRole(false);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.h,
                                          vertical: 10.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: controller.isPersonal == false
                                              ? AppColors.secondary
                                              : AppColors.backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Text(
                                          "Môi giới",
                                          style: AppTextStyles.roboto14semiBold
                                              .copyWith(
                                                  color: controller
                                                              .isPersonal ==
                                                          false
                                                      ? AppColors.primaryColor
                                                      : AppColors.gery2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Seperator(
                            height: 10.h,
                          ),
//CHI TIET
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Thông tin bài đăng",
                                  style: AppTextStyles.roboto20semiBold,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormCustom(
                                  label: "Tiêu đề",
                                  hint: "(Tiêu đề)",
                                  error: "Vui lòng nhập tiêu đề",
                                  onSave: (value) {
                                    controller.title = value!;
                                  },
                                  fieldValue: controller.title,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormCustom(
                                  label: "Mô tả chi tiết",
                                  hint: "(Mô tả chi tiết)",
                                  error: "Vui lòng nhập mô tả chi tiết",
                                  onSave: (value) {
                                    controller.description = value!;
                                  },
                                  fieldValue: controller.description,
                                ),
                              ],
                            ),
                          ),
                          Seperator(
                            height: 10.h,
                          ),
//DIA CHI HINH ANH
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Địa chỉ & Hình ảnh",
                                  style: AppTextStyles.roboto20semiBold,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                //Tên tòa/khu dân cư/ dự án
                                TextFormCustom(
                                  label: "Tên tòa nhà / khu dân cư / dự án ",
                                  hint: controller.selectedPropertyType ==
                                          PropertyType.land
                                      ? "(Không bắt buộc)"
                                      : "(Tên tòa nhà / khu dân cư / dự án)",
                                  error: "Vui lòng nhập thông tin",
                                  onSave: (v) {
                                    controller.projectName = v ?? "";
                                  },
                                  fieldValue: controller.projectName,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                //Địa chỉ
                                TextFormField(
                                  onTap: () {
                                    Get.to(() => const PostAddressScreen());
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng chọn địa chỉ';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: controller.addressController,
                                  enabled: true,
                                  decoration: InputDecoration(
                                    hintText: "Địa chỉ",
                                    hintStyle: AppTextStyles.roboto16regular
                                        .copyWith(color: AppColors.grey),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.r)),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.r)),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                  ),
                                ),
                                //Tầng + Block
                                SizedBox(
                                  height: 10.h,
                                ),
                                Visibility(
                                  visible: controller.selectedPropertyType ==
                                          PropertyType.apartment
                                      ? true
                                      : false,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.46,
                                        child: TextFormCustom(
                                          fieldValue:
                                              controller.floor.toString(),
                                          label: "Tầng",
                                          hint: "(Tầng)",
                                          error: "Vui lòng nhập tầng",
                                          onSave: (v) {
                                            controller.floor = int.parse(v!);
                                          },
                                          keyBoardType: TextInputType.number,
                                          onValidate: validateCount,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.46,
                                        child: TextFormCustom(
                                          fieldValue: controller.block,
                                          label: "Block/Tháp",
                                          hint: "(Block/Tháp)",
                                          error: "Vui lòng nhập Block/Tháp",
                                          onSave: (v) {
                                            controller.block = v!;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DottedBorder(
                                radius: Radius.circular(5.r),
                                strokeWidth: 1,
                                dashPattern: const [5, 2],
                                color: controller.photoController == false
                                    ? Colors.red
                                    : AppColors.primaryColor,
                                child: controller.photo.isEmpty
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20.w,
                                        height: 200.h,
                                        child: GestureDetector(
                                          onTap: () {
                                            _showPicker(context, controller);
                                          },
                                          child: Center(
                                            child: Image(
                                              height: 100.h,
                                              width: 100.w,
                                              image: const AssetImage(
                                                  "assets/images/add_photo_alternate.png"),
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20.w,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 200.h,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    controller.photo.length + 1,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SizedBox(
                                                    height: 190.h,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 3.w),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .backgroundColor),
                                                      child: index == 0
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                _showPicker(
                                                                    context,
                                                                    controller);
                                                                //controller.imgFromGallery();
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10.h),
                                                                // width: MediaQuery.of(context).size.width - 20.w,
                                                                height: 80.h,
                                                                width: 80.h,
                                                                child:
                                                                    const Image(
                                                                  image: AssetImage(
                                                                      "assets/images/add_photo_alternate.png"),
                                                                ),
                                                              ),
                                                            )
                                                          : Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Image.file(
                                                                  File(controller
                                                                      .photo[
                                                                          index -
                                                                              1]
                                                                      .path),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 190.h,
                                                                ),
                                                                Positioned(
                                                                  top: -10.h,
                                                                  right: -10.w,
                                                                  child:
                                                                      IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .close,
                                                                      size:
                                                                          20.h,
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      controller.deleteImage(
                                                                          index -
                                                                              1);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Visibility(
                                  visible: controller.photoController == false,
                                  child: Text(
                                    "     Số lượng hình ảnh từ 3 đến 10 hình",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12.sp),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Seperator(
                            height: 10.h,
                          ),
                          //THONG TIN CHI TIET
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                    visible: controller.selectedPropertyType !=
                                        PropertyType.motel,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Thông tin chi tiết",
                                          style: AppTextStyles.roboto16semiBold,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    )),
                                //Visibility(child: Container())
                                //VAN PHONG
                                Visibility(
                                    visible: controller.selectedPropertyType ==
                                            PropertyType.office
                                        ? true
                                        : false,
                                    child: Column(
                                      children: [
                                        DropDownButtonFormFieldCustom(
                                          hint: "Loại hình văn phòng",
                                          items: controller.officeMap,
                                          fieldValue: controller.officeType,
                                          onSave: (v) {
                                            controller.officeType = v;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        DropDownButtonFormFieldCustom(
                                          hint: "Hướng cửa chính",
                                          items: controller.directionMap,
                                          fieldValue: controller.directionDoor,
                                          onSave: (v) {
                                            controller.directionDoor = v;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    )),
                                //DAT
                                Visibility(
                                  visible: controller.selectedPropertyType ==
                                          PropertyType.land
                                      ? true
                                      : false,
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.46,
                                          child: TextFormCustom(
                                            fieldValue:
                                                controller.subdivisionName ??
                                                    controller.subdivisionName
                                                        .toString(),
                                            label: "Tên phân khu",
                                            hint: "(Không bắt buộc)",
                                            onSave: (v) {
                                              controller.subdivisionName = v;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.46,
                                          child: TextFormCustom(
                                            fieldValue: controller.landCode ??
                                                controller.landCode.toString(),
                                            label: "Mã lô",
                                            hint: "(Không bắt buộc)",
                                            onSave: (v) {
                                              controller.landCode = v;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    DropDownButtonFormFieldCustom(
                                      hint: "Loại hình đất",
                                      items: controller.landMap,
                                      fieldValue: controller.landType,
                                      onSave: (v) {
                                        controller.landType = v;
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    DropDownButtonFormFieldCustom(
                                      hint: "Hướng đất chính",
                                      items: controller.directionMap,
                                      fieldValue: controller.landDirection,
                                      onSave: (v) {
                                        controller.landDirection = v;
                                      },
                                    )
                                  ]),
                                ),
                                //CAN HO, CHUNG CU
                                Visibility(
                                    visible: controller.selectedPropertyType ==
                                            PropertyType.apartment
                                        ? true
                                        : false,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tình trạng bất động sản",
                                          style: AppTextStyles.roboto12semiBold,
                                        ),
                                        //Bàn giap, chưa bàn giao
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.setHandOver(true);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 15.h,
                                                  vertical: 10.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      controller.isHandover ==
                                                              true
                                                          ? AppColors.secondary
                                                          : AppColors
                                                              .backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                ),
                                                child: Text(
                                                  "Đã bàn giao",
                                                  style: AppTextStyles
                                                      .roboto14semiBold
                                                      .copyWith(
                                                          color: controller
                                                                      .isHandover ==
                                                                  true
                                                              ? AppColors
                                                                  .primaryColor
                                                              : AppColors
                                                                  .gery2),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.setHandOver(false);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 15.h,
                                                  vertical: 10.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      controller.isHandover ==
                                                              false
                                                          ? AppColors.secondary
                                                          : AppColors
                                                              .backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r),
                                                ),
                                                child: Text(
                                                  "Chưa bàn giao",
                                                  style: AppTextStyles
                                                      .roboto14semiBold
                                                      .copyWith(
                                                          color: controller
                                                                      .isHandover ==
                                                                  false
                                                              ? AppColors
                                                                  .primaryColor
                                                              : AppColors
                                                                  .gery2),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        //Loại hình căn hộ
                                        DropDownButtonFormFieldCustom(
                                          hint: "Loại hình căn hộ",
                                          items: controller.apartmentMap,
                                          fieldValue: controller.apartmentType,
                                          onSave: (v) {
                                            controller.apartmentType = v;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    )),
                                //NHA O
                                Visibility(
                                    visible: controller.selectedPropertyType ==
                                                PropertyType.house ||
                                            controller.selectedPropertyType ==
                                                PropertyType.apartment
                                        ? true
                                        : false,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //Loại hình nhà ở
                                        Visibility(
                                            visible: controller
                                                        .selectedPropertyType ==
                                                    PropertyType.house
                                                ? true
                                                : false,
                                            child: Column(
                                              children: [
                                                DropDownButtonFormFieldCustom(
                                                  hint: "Loại hình nhà ở",
                                                  items: controller.houseMap,
                                                  fieldValue:
                                                      controller.houseType,
                                                  onSave: (v) {
                                                    controller.houseType = v;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                              ],
                                            )),
                                        //         //Số phòng ngủ/ số phòng vệ sinh
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.46,
                                              child: TextFormCustom(
                                                label: "Số phòng ngủ",
                                                hint: "(Không bắt buộc)",
                                                onSave: (v) {
                                                  controller.numberOfBedroom =
                                                      v != null
                                                          ? int.tryParse(v)
                                                          : null;
                                                },
                                                keyBoardType:
                                                    TextInputType.number,
                                                onValidate: validateCount,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.46,
                                              child: TextFormCustom(
                                                label: "Số phòng vệ sinh",
                                                hint: "(Không bắt buộc)",
                                                onSave: (v) {
                                                  controller.numberOfToilet =
                                                      v != null
                                                          ? int.tryParse(v)
                                                          : null;
                                                },
                                                keyBoardType:
                                                    TextInputType.number,
                                                onValidate: validateCount,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        TextFormCustom(
                                          fieldValue:
                                              controller.numberOfFloor != null
                                                  ? controller.numberOfFloor
                                                      .toString()
                                                  : "",
                                          label: "Số tầng",
                                          hint: "(Không bắt buộc)",
                                          onSave: (v) {
                                            controller.numberOfFloor = v != null
                                                ? int.tryParse(v)
                                                : null;
                                          },
                                          keyBoardType: TextInputType.number,
                                          onValidate: validateCount,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        DropDownButtonFormFieldCustom(
                                          hint: "Hướng ban công",
                                          isCompulsory: false,
                                          items: controller.directionMap,
                                          fieldValue:
                                              controller.balconyDirection,
                                          onSave: (v) {
                                            controller.balconyDirection = v;
                                          },
                                        ),
                                        SizedBox(height: 10.h),
                                        DropDownButtonFormFieldCustom(
                                          hint: "Hướng cửa chính",
                                          isCompulsory: false,
                                          items: controller.directionMap,
                                          fieldValue: controller.directionDoor,
                                          onSave: (v) {
                                            controller.directionDoor = v;
                                          },
                                        ),
                                        //         //Hướng ban công, hướng cửa chính
                                      ],
                                    )),
                              ],
                            ),
                          ),
//DIỆN TÍCH VÀ GIÁ
                          Seperator(
                            height: 10.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Diện tích & Giá",
                                  style: AppTextStyles.roboto20semiBold,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormCustom(
                                  fieldValue: controller.area != 0
                                      ? controller.area.toString()
                                      : "",
                                  label: "Diện tích",
                                  hint: "(Diện tích)",
                                  error: "Vui lòng nhập diện tích",
                                  onSave: (v) {
                                    controller.area = double.parse(v!);
                                  },
                                  keyBoardType: TextInputType.number,
                                  onValidate: validatePositiveDouble,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Visibility(
                                  visible: controller.selectedPropertyType ==
                                              PropertyType.land ||
                                          controller.selectedPropertyType ==
                                              PropertyType.house
                                      ? true
                                      : false,
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.46,
                                            child: TextFormCustom(
                                              fieldValue: controller.height != 0
                                                  ? controller.height.toString()
                                                  : "",
                                              label: "Chiều dài",
                                              hint: "Nhập chiều dài",
                                              onSave: (v) {
                                                controller.height =
                                                    double.parse(v!);
                                              },
                                              keyBoardType:
                                                  TextInputType.number,
                                              onValidate:
                                                  validatePositiveDouble,
                                            )),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.46,
                                            child: TextFormCustom(
                                              fieldValue: controller.width != 0
                                                  ? controller.width.toString()
                                                  : "",
                                              label: "Chiều ngang",
                                              hint: "Nhập chiều rộng",
                                              onSave: (v) {
                                                controller.width =
                                                    double.parse(v!);
                                              },
                                              keyBoardType:
                                                  TextInputType.number,
                                              onValidate:
                                                  validatePositiveDouble,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    )
                                  ]),
                                ),
                                Visibility(
                                  visible: controller.selectedPropertyType ==
                                          PropertyType.house
                                      ? true
                                      : false,
                                  child: Column(
                                    children: [
                                      TextFormCustom(
                                        fieldValue: controller.usedArea != null
                                            ? controller.usedArea.toString()
                                            : "",
                                        label: "Diện tích sử dụng",
                                        hint: "(Không bắt buộc)",
                                        onSave: (v) {
                                          controller.usedArea =
                                              v != null && v.isEmpty == false
                                                  ? double.parse(v)
                                                  : null;
                                        },
                                        keyBoardType: TextInputType.number,
                                        onValidate: validatePositiveDouble,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      )
                                    ],
                                  ),
                                ),
                                TextFormCustom(
                                  fieldValue: controller.price != 0
                                      ? controller.price.toString()
                                      : "",
                                  label: "Giá",
                                  hint: "(Giá)",
                                  error: "Vui lòng nhập giá (Vnđ)",
                                  onSave: (v) {
                                    controller.price = int.parse(v!);
                                  },
                                  keyBoardType: TextInputType.number,
                                  onValidate: validateCount,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                //PHONG TRO
                                Visibility(
                                    visible: controller.selectedPropertyType ==
                                            PropertyType.motel
                                        ? true
                                        : false,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.46,
                                              child: TextFormCustom(
                                                fieldValue:
                                                    controller.waterPrice !=
                                                            null
                                                        ? controller.waterPrice
                                                            .toString()
                                                        : "",
                                                label: "Tiền nước",
                                                hint: "(Không bắt buộc)",
                                                onSave: (v) {
                                                  controller.electricPrice =
                                                      v != null
                                                          ? int.tryParse(v)
                                                          : null;
                                                },
                                                keyBoardType:
                                                    TextInputType.number,
                                                onValidate: validateCount,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.46,
                                              child: TextFormCustom(
                                                fieldValue: controller
                                                            .electricPrice !=
                                                        null
                                                    ? controller.electricPrice
                                                        .toString()
                                                    : "",
                                                label: "Tiền điện",
                                                hint: "(Không bắt buộc)",
                                                onSave: (v) {
                                                  controller.waterPrice =
                                                      v != null
                                                          ? int.tryParse(v)
                                                          : null;
                                                },
                                                keyBoardType:
                                                    TextInputType.number,
                                                onValidate: validateCount,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    )),
                                Visibility(
                                    visible: controller.isSale == false &&
                                        controller.selectedPropertyType !=
                                            PropertyType.motel,
                                    child: Column(
                                      children: [
                                        TextFormCustom(
                                          fieldValue: controller.deposit != null
                                              ? controller.deposit.toString()
                                              : "",
                                          label: "Số tiền cọc",
                                          hint: "(Không bắt buộc)",
                                          onSave: (v) {
                                            controller.deposit = v != null
                                                ? int.tryParse(v)
                                                : null;
                                          },
                                          keyBoardType: TextInputType.number,
                                          onValidate: validatePositiveDouble,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    )),
                                Visibility(
                                    visible: controller.selectedPropertyType ==
                                        PropertyType.motel,
                                    child: Column(
                                      children: [
                                        TextFormCustom(
                                          fieldValue:
                                              controller.modelDeposit != 0
                                                  ? controller.modelDeposit
                                                      .toString()
                                                  : "",
                                          label: "Số tiền cọc",
                                          hint: "(Số tiền cọc)",
                                          onSave: (v) {
                                            controller.modelDeposit =
                                                int.parse(v!);
                                          },
                                          keyBoardType: TextInputType.number,
                                          onValidate: validatePositiveDouble,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),

                          Seperator(
                            height: 10.h,
                          ),
//THÔNG TIN KHÁC
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Thông tin khác",
                                  style: AppTextStyles.roboto20semiBold,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),

                                Visibility(
                                  visible: controller.selectedPropertyType !=
                                          PropertyType.motel
                                      ? true
                                      : false,
                                  child: Column(
                                    children: [
                                      DropDownButtonFormFieldCustom(
                                          hint: "Giấy tờ pháp lý",
                                          items: controller.certificateMap,
                                          fieldValue: controller.legalStatus,
                                          onSave: (v) {
                                            controller.legalStatus = v;
                                          }),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: controller.selectedPropertyType !=
                                          PropertyType.land
                                      ? true
                                      : false,
                                  child: Column(
                                    children: [
                                      DropDownButtonFormFieldCustom(
                                          hint: "Tình trạng nội thất",
                                          items: controller.iteriorMap,
                                          fieldValue:
                                              controller.furnitureStatus,
                                          onSave: (v) {
                                            controller.furnitureStatus = v;
                                          }),
                                    ],
                                  ),
                                ),
                                //Đặc điểm nhà đất
                                SizedBox(
                                  height: 5.h,
                                ),
                                Visibility(
                                    visible: controller.selectedPropertyType !=
                                            PropertyType.motel
                                        ? true
                                        : false,
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Đặc điểm nhà đất",
                                            style:
                                                AppTextStyles.roboto12semiBold,
                                          ),
                                          controller.selectedPropertyType ==
                                                  PropertyType.office
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CheckFormField(
                                                      name: "Mặt tiền",
                                                      onChange: (v) {
                                                        controller.isFacade = v;
                                                      },
                                                      initialValue:
                                                          controller.isFacade,
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  height: 0,
                                                ),
                                          controller.selectedPropertyType ==
                                                  PropertyType.land
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CheckFormField(
                                                      name: "Mặt tiền",
                                                      onChange: (v) {
                                                        controller.isFacade = v;
                                                      },
                                                      initialValue:
                                                          controller.isFacade,
                                                    ),
                                                    CheckFormField(
                                                      name: "Nở hậu",
                                                      onChange: (v) {
                                                        controller
                                                            .isWidensTowardsTheBack = v;
                                                      },
                                                      initialValue: controller
                                                          .isWidensTowardsTheBack,
                                                    ),
                                                    CheckFormField(
                                                      name: "Hẻm xe hơi",
                                                      onChange: (v) {
                                                        controller
                                                            .hasWideAlley = v;
                                                      },
                                                      initialValue: controller
                                                          .hasWideAlley,
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  height: 0,
                                                ),
                                          controller.selectedPropertyType ==
                                                  PropertyType.house
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CheckFormField(
                                                      name: "Mặt tiền",
                                                      onChange: (v) {
                                                        controller.isFacade = v;
                                                      },
                                                      initialValue:
                                                          controller.isFacade,
                                                    ),
                                                    CheckFormField(
                                                      name: "Nở hậu",
                                                      onChange: (v) {
                                                        controller
                                                            .isWidensTowardsTheBack = v;
                                                      },
                                                      initialValue: controller
                                                          .isWidensTowardsTheBack,
                                                    ),
                                                    CheckFormField(
                                                      name: "Hẻm xe hơi",
                                                      onChange: (v) {
                                                        controller
                                                            .hasWideAlley = v;
                                                      },
                                                      initialValue: controller
                                                          .hasWideAlley,
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  height: 0,
                                                ),
                                          controller.selectedPropertyType ==
                                                  PropertyType.apartment
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CheckFormField(
                                                        name: "Căn góc",
                                                        initialValue:
                                                            controller.isCorner,
                                                        onChange: (v) {
                                                          controller.isCorner =
                                                              v;
                                                        }),
                                                  ],
                                                )
                                              : Container(
                                                  height: 0,
                                                ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              controller.checkLengthPhoto();
                              if (_formKey.currentState!.validate() &&
                                  controller.photoController == true) {
                                _formKey.currentState!.save();
                                await controller.addPost();
                                const snackBar = SnackBar(
                                  content: Text(
                                    'Đăng tin thành công!',
                                  ),
                                );
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                const snackBar = SnackBar(
                                  content: Text(
                                    'Thông tin không hợp lệ!',
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.h),
                                color: AppColors.primaryColor,
                              ),
                              child: SizedBox(
                                  width: double.maxFinite,
                                  height: 30.h,
                                  child: Center(
                                      child: Text(
                                    "Đăng tin",
                                    style: AppTextStyles.roboto20semiBold
                                        .copyWith(color: Colors.white),
                                  ))),
                            ),
                          )
                        ])),
                  ],
                );
              },
            )),
      ),
    );
  }
}
