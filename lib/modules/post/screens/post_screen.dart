import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/data/models/address.dart';
import 'package:nha_gia_re/data/services/validate_service.dart';
import 'package:nha_gia_re/modules/post/post_controller.dart';
import 'package:nha_gia_re/modules/post/property_controller.dart';
import 'package:nha_gia_re/modules/post/screens/post_address.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:nha_gia_re/modules/post/widgets/check_field.dart';
import 'package:nha_gia_re/modules/post/widgets/dropdownfied.dart';
import 'package:nha_gia_re/modules/post/widgets/seperator.dart';
import 'package:nha_gia_re/modules/post/widgets/textformfield.dart';
import '../widgets/hostel_body.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(411,683));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Đăng tin"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: GetBuilder<PropertyController>(builder: (controller) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                              borderSide: const BorderSide(color: Colors.black)
                          ),
                        ),
                        hint: Text("Chọn loại bất động sản"),
                        items: controller.propertyTypeList.map((value) {
                          return DropdownMenuItem<String>(value: value, child: Text(value),);
                        }).toList(),
                        onChanged: (value) {
                          controller.setVisibility(controller.propertyTypeList.indexOf(value!));
                        },
                        onSaved: (value) {
                          if (value == null || value!.isEmpty) return;
                            controller.propertyType = value!;
                          print("Save DropDown Fied" + value.toString());
                        },
                      ),
                    ),
                    Visibility(
                      visible: controller.selectedIndex != 3 && controller.selectedIndex != -1 ? true: false,
                      child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              controller.setWork(true);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.h,
                                vertical: 10.w,
                              ),
                              decoration: BoxDecoration(
                                color: controller.isSale == true? AppColors.primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: Colors.black, width: 0.6.w)
                              ),
                              child: Text("Cần bán",
                                style: AppTextStyles.roboto14semiBold.copyWith(
                                    color: Colors.black),),
                            ),
                          ),
                          SizedBox(width: 20.w,),
                          GestureDetector(
                            onTap: (){
                              controller.setWork(false);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.h,
                                vertical: 10.w,
                              ),
                              decoration: BoxDecoration(
                                color: controller.isSale == false? AppColors.primaryColor: Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(color: Colors.black, width: 0.6.w)
                              ),
                              child: Text("Cho thuê",
                                style: AppTextStyles.roboto14semiBold.copyWith(
                                    color: Colors.black),),
                            ),
                          ),
                        ],),
                    ),),
                    SizedBox(height: 10.h,),
                    Visibility(
                        visible: controller.selectedIndex != -1 ? true: false,
                        child: Column(
                            children: [
                              const Seperator(height: 10,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Bạn là",
                                      style: AppTextStyles.roboto20semiBold,),
                                    SizedBox(height: 10.h,),
                                    Text("Cá nhân/ Môi giới",
                                      style: AppTextStyles.roboto12regular,),
                                    SizedBox(height: 3.h,),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            controller.setRole(true);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15.h,
                                              vertical: 10.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: controller.isPersonal == true? AppColors.secondary : AppColors.backgroundColor,
                                              borderRadius: BorderRadius.circular(15.r),
                                            ),
                                            child: Text("Cá nhân",
                                              style: AppTextStyles.roboto14semiBold.copyWith(
                                                  color: controller.isPersonal == true ? AppColors.primaryColor : AppColors.gery2),),
                                          ),
                                        ),
                                        SizedBox(width: 20.w,),
                                        GestureDetector(
                                          onTap: (){
                                            controller.setRole(false);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15.h,
                                              vertical: 10.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: controller.isPersonal == false? AppColors.secondary: AppColors.backgroundColor,
                                              borderRadius: BorderRadius.circular(15.r),
                                            ),
                                            child: Text("Môi giới",
                                              style: AppTextStyles.roboto14semiBold.copyWith(
                                                  color: controller.isPersonal == false ? AppColors.primaryColor : AppColors.gery2),),
                                          ),
                                        ),
                                      ],),
                                  ],
                                ),
                              ),
                              Seperator(height: 10.h,),
//CHI TIET
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Thông tin bài đăng",
                                      style: AppTextStyles.roboto20semiBold,),
                                    SizedBox(height: 10.h,),
                                    TextFormCustom(label: "Tiêu đề", hint: "(Tiêu đề)", error: "Vui lòng nhập tiêu đề", onSave:(value){controller.title = value;} ,),
                                    SizedBox(height: 10.h,),
                                    TextFormCustom(label: "Mô tả chi tiết", hint: "(Mô tả chi tiết)", error: "Vui lòng nhập mô tả chi tiết", onSave:(value){controller.description = value;}),
                                  ],
                                ),
                              ),
                              Seperator(height: 10.h,),
//DIA CHI HINH ANH
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Địa chỉ & Hình ảnh",
                                      style: AppTextStyles.roboto20semiBold,),
                                    SizedBox(height: 10.h,),
                                    //Tên tòa/khu dân cư/ dự án
                                    TextFormCustom(label: "Tên tòa nhà / khu dân cư / dự án ", hint:controller.selectedIndex==1 ?"(Không bắt buộc)":"(Tên tòa nhà / khu dân cư / dự án)", error: "Vui lòng nhập thông tin", onSave: (v){controller.projectName = v;},),
                                    SizedBox(height: 10.h,),
                                    //Địa chỉ
                                    GestureDetector(
                                        onTap: (){
                                          Get.to(PostAddressScreen());
                                        },
                                        child: Container(
                                          child: TextFormField(
                                            initialValue: controller.addressDisplay,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              hintText: "Địa chỉ",
                                              hintStyle: AppTextStyles.roboto16regular.copyWith(color: AppColors.grey),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                                borderSide:const BorderSide(color: Colors.grey),),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                                  borderSide:const BorderSide(color: Colors.grey)
                                              ),
                                            ),
                                          ),
                                        )
                                    ),
                                    //Tầng + Block
                                    SizedBox(height: 10.h,),
                                    Visibility(
                                      visible: controller.selectedIndex ==4?true:false,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.46,
                                            child: TextFormCustom(label: "Tầng", hint: "(Tầng)", error: "Vui lòng nhập tầng", onSave: (v){controller.floor = v;}, keyBoardType: TextInputType.number, onValidate: validateCount,),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.46,
                                            child: TextFormCustom(label: "Block/Tháp", hint: "(Block/Tháp)", error: "Vui lòng nhập Block/Tháp", onSave: (v){controller.block = v;},),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              DottedBorder(
                                radius: Radius.circular(5.r),
                                strokeWidth: 1,
                                dashPattern: [5,2],
                                color: AppColors.primaryColor,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.h),
                                  width: MediaQuery.of(context).size.width - 20.w,
                                  height: 50.h,
                                  child: Center(
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/add_photo_alternate.png"
                                      ),
                                    ),
                                  ),
                                ),

                              ),
                              SizedBox(height: 10.h,),
                              Seperator(height: 10.h,),
                              //THONG TIN CHI TIET
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                width: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                        visible: controller.selectedIndex!=3,
                                        child: Column(
                                      children: [
                                        Text("Thông tin chi tiết",
                                          style: AppTextStyles.roboto16semiBold,),
                                        SizedBox(height: 10.h,),
                                      ],
                                    )),
                                    //Visibility(child: Container())
                                    //VAN PHONG
                                    Visibility(
                                        visible: controller.selectedIndex == 0? true: false,
                                        child: Column(
                                          children: [
                                            DropDownButtonFormFieldCustom( hint: "Loại hình văn phòng", items: controller.apartmentTypeList, fieldValue: controller.officeType, onSave: (v){controller.apartmentType = v;},),
                                            SizedBox(height: 10.h,),
                                            DropDownButtonFormFieldCustom( hint: "Hướng cửa chính", items: controller.directionList, fieldValue: controller.directionDoor, onSave: (v){ controller.directionDoor = v;},),
                                            SizedBox(height: 10.h,),
                                          ],
                                        )),
                                    //DAT
                                    Visibility(
                                      visible: controller.selectedIndex ==1?true:false,
                                      child: Column(
                                          children:[ Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.46,
                                                child: TextFormCustom(label: "Tên phân khu", hint: "(Không bắt buộc)", onSave: (v){controller.subdivisionName = v;},),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width*0.46,
                                                child: TextFormCustom(label: "Mã lô", hint: "(Không bắt buộc)", onSave: (v){controller.landCode = v;},),
                                              )
                                            ],

                                          ),
                                            SizedBox(height: 10.h),
                                            DropDownButtonFormFieldCustom( hint: "Loại hình đất", items: controller.landTypeList, fieldValue: controller.landType,onSave: (v){controller.landType = v;},),
                                            SizedBox(height: 10.h,),
                                            DropDownButtonFormFieldCustom(hint: "Hướng đất chính", items: controller.directionList, fieldValue: controller.landDirection, onSave: (v){controller.landDirection = v;},)

                                          ]
                                      ),
                                    ),
                                    //CAN HO, CHUNG CU
                                    Visibility(
                                        visible: controller.selectedIndex == 4? true: false,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Tình trạng bất động sản", style: AppTextStyles.roboto12semiBold,),
                                            //Bàn giap, chưa bàn giao
                                            SizedBox(height: 4.h,),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    controller.setHandOver(true);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 15.h,
                                                      vertical: 10.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: controller.isHandover == true? AppColors.secondary : AppColors.backgroundColor,
                                                      borderRadius: BorderRadius.circular(15.r),
                                                    ),
                                                    child: Text("Đã bàn giao",
                                                      style: AppTextStyles.roboto14semiBold.copyWith(
                                                          color: controller.isHandover == true ? AppColors.primaryColor : AppColors.gery2),),
                                                  ),
                                                ),
                                                SizedBox(width: 20.w,),
                                                GestureDetector(
                                                  onTap: (){
                                                    controller.setHandOver(false);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 15.h,
                                                      vertical: 10.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: controller.isHandover == false? AppColors.secondary: AppColors.backgroundColor,
                                                      borderRadius: BorderRadius.circular(15.r),
                                                    ),
                                                    child: Text("Chưa bàn giao",
                                                      style: AppTextStyles.roboto14semiBold.copyWith(
                                                          color: controller.isHandover == false ? AppColors.primaryColor : AppColors.gery2),),
                                                  ),
                                                ),
                                              ],),
                                            SizedBox(height: 10.h,),
                                            //Loại hình căn hộ
                                            DropDownButtonFormFieldCustom( hint: "Loại hình căn hộ", items: controller.apartmentTypeList, fieldValue: controller.apartmentType, onSave: (v){controller.apartmentType = v;},),
                                            SizedBox(height: 10.h,),
                                          ],
                                        )),
                                    //NHA O
                                    Visibility(
                                        visible: controller.selectedIndex == 4 || controller.selectedIndex == 2 ? true: false,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //Loại hình nhà ở
                                            Visibility(
                                                visible: controller.selectedIndex == 2? true: false,
                                                child: Column(
                                                  children: [
                                                    DropDownButtonFormFieldCustom( hint: "Loại hình nhà ở", items: controller.houseTypeList, onSave: (v){controller.houseType = v;}, ),
                                                    SizedBox(height: 10.h,),
                                                  ],
                                                )),
                                    //         //Số phòng ngủ/ số phòng vệ sinh
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.46,
                                                  child: TextFormCustom(label: "Số phòng ngủ", hint: "(Không bắt buộc)", onSave: (v){controller.numberOfBedroom = v;}, keyBoardType: TextInputType.number, onValidate: validateCount,),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.46,
                                                  child: TextFormCustom(label: "Số phòng vệ sinh", hint: "(Không bắt buộc)", onSave: (v){controller.numberOfToilet = v;}, keyBoardType: TextInputType.number, onValidate: validateCount,),
                                                )
                                              ],),
                                              SizedBox(height: 10.h,),
                                    //         //Hướng ban công, hướng cửa chính
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.46,
                                                  child: DropDownButtonFormFieldCustom( hint: "Hướng ban công", items: controller.directionList, fieldValue: controller.balconyDirection, onSave: (v){controller.balconyDirection = v;},),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width*0.46,
                                                  child: DropDownButtonFormFieldCustom( hint: "Hướng cửa chính", items: controller.directionList, fieldValue: controller.directionDoor, onSave: (v){controller.directionDoor = v;},),
                                                )
                                              ],),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
//DIỆN TÍCH VÀ GIÁ
                              Seperator(height: 10.h,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Diện tích & Giá",
                                      style: AppTextStyles.roboto20semiBold,),
                                    SizedBox(height: 10.h,),
                                    TextFormCustom(label: "Diện tích", hint: "(Diện tích)", error: "Vui lòng nhập diện tích", onSave: (v){controller.area = v;}, keyBoardType: TextInputType.number, onValidate: validatePositiveDouble,),
                                    SizedBox(height: 10.h,),
                                    Visibility(
                                      visible: controller.selectedIndex == 1 || controller.selectedIndex == 2? true: false,
                                      child:Column(
                                          children:[ Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context).size.width*0.46 ,
                                                  child: TextFormCustom(label: "Chiều dài", hint: "(Không bắt buộc)", onSave: (v){controller.height = v;}, keyBoardType: TextInputType.number, onValidate: validatePositiveDouble,)),
                                              Container(
                                                  width: MediaQuery.of(context).size.width*0.46 ,
                                                  child: TextFormCustom(label: "Chiều ngang", hint: "(Không bắt buộc)", onSave: (v){controller.width = v;}, keyBoardType: TextInputType.number, onValidate: validatePositiveDouble,)),
                                            ],),
                                            SizedBox(height: 10.h,)
                                          ]
                                      ),
                                    ),
                                    Visibility(
                                      visible: controller.selectedIndex == 2? true: false,
                                      child:Column(
                                        children:[
                                          TextFormCustom(label: "Diện tích sử dụng", hint: "(Không bắt buộc)", onSave: (v){controller.usedArea = v;}, keyBoardType: TextInputType.number, onValidate: validatePositiveDouble,),
                                          SizedBox(height: 10.h,)
                                        ],
                                      ),
                                    ),
                                    TextFormCustom(label: "Giá", hint: "(Giá)", error: "Vui lòng nhập giá (Vnđ)", onSave: (v){controller.price = v;}, keyBoardType: TextInputType.number, onValidate: validatePositiveDouble,),
                                    SizedBox(height: 10.h,),
                                    Visibility(
                                        visible: controller.isSale! == false,
                                        child: Column(
                                          children: [
                                            TextFormCustom(label: "Số tiền cọc", hint: "(Không bắt buộc (Vnđ))", onSave: (v){controller.deposit = v;}, keyBoardType: TextInputType.number, onValidate: validatePositiveDouble,),
                                            SizedBox(height: 10.h,),
                                          ],
                                        )),
                                  ],
                                ),
                              ),

                              Seperator(height: 10.h,),
//THÔNG TIN KHÁC
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Thông tin khác",
                                      style: AppTextStyles.roboto20semiBold,),
                                    SizedBox(height: 10.h,),

                                    Visibility(
                                      visible: controller.selectedIndex != 3? true: false,
                                      child: Column(
                                        children: [
                                          DropDownButtonFormFieldCustom(hint: "Giấy tờ pháp lý", items: controller.propertyCertificate, fieldValue: controller.legalStatus,  onSave: (v){controller.legalStatus = v;}),
                                          SizedBox(height: 10.h,),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: controller.selectedIndex != 1? true: false,
                                      child: Column(
                                        children: [
                                          DropDownButtonFormFieldCustom(hint: "Tình trạng nội thất", items: controller.iteriorStateList, fieldValue: controller.interiorState, onSave: (v){controller.interiorState = v;}),
                                          SizedBox(height: 10.h,),
                                        ],
                                      ),
                                    ),
                                    //Đặc điểm nhà đất
                                    Visibility(
                                        visible: controller.selectedIndex != 3? true: false,
                                        child: Container(
                                          width: double.maxFinite,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Đặc điểm nhà đất", style: AppTextStyles.roboto12semiBold,),
                                              controller.selectedIndex == 0?Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  CheckFormField(name: "Mặt tiền", onChange: (v){controller.isFacade = v;}, initialValue: controller.isFacade,),
                                                ],
                                              ):Container(height: 0,),
                                              controller.selectedIndex == 1?Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  CheckFormField(name: "Mặt tiền", onChange: (v){controller.isFacade = v;}, initialValue: controller.isFacade,),
                                                  CheckFormField(name:"Nở hậu", onChange: (v){controller.isWidensTowardsTheBack = v;}, initialValue: controller.isWidensTowardsTheBack,),
                                                  CheckFormField(name: "Hẻm xe hơi", onChange: (v){controller.hasWideAlley = v;}, initialValue: controller.hasWideAlley,),
                                                ],
                                              ):Container(height: 0,),
                                              controller.selectedIndex == 2?Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  CheckFormField(name: "Mặt tiền", onChange: (v){controller.isFacade = v;}, initialValue: controller.isFacade,),
                                                  CheckFormField(name: "Hẻm xe hơi", onChange: (v){controller.hasWideAlley = v;}, initialValue: controller.hasWideAlley,),
                                                ],
                                              ):Container(height: 0,),
                                              controller.selectedIndex == 4?Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  CheckFormField(name: "Căn góc", initialValue: controller.isCorner , onChange: (v){controller.isCorner = v;}),
                                                ],
                                              ):Container(height: 0,),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  if(_formKey.currentState!.validate()){
                                    _formKey.currentState!.save();
                                    print("Save Success!");
                                    print("Diện tích" + controller.area + controller.title);
                                    print("Loai " +controller.propertyType +
                                        " Hướng cửa "+ controller.directionDoor.toString()
                                        + " Giá " + controller.price.toString()
                                    );
                                  }
                                  else {
                                    print("Validate failed!");
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical:3.h),
                                  margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.h),
                                    color: AppColors.primaryColor,
                                  ),
                                   child: SizedBox(width: double.maxFinite,
                                    height: 20.h,
                                    child: Center(child: Text("Đăng tin", style: AppTextStyles.roboto20semiBold.copyWith(color: Colors.white),))
                                ),
                                ),
                              )
                            ]
                        )),
                  ],
                ),);
            },)
        ),
      ),
    );
  }
}

