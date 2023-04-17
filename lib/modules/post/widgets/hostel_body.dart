// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:nha_gia_re/core/theme/text_styles.dart';
// import 'package:nha_gia_re/modules/post/widgets/seperator.dart';
// import 'package:nha_gia_re/modules/post/widgets/textformfield.dart';
//
// import '../../../core/theme/app_colors.dart';
// import '../post_controller.dart';
// import '../screens/post_address.dart';
// import 'dropdownfied.dart';
//
// class HostelBody extends StatelessWidget {
//   const HostelBody({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var postcontroller = Get.find<PostController>();
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Thông tin bài đăng",
//                 style: AppTextStyles.roboto20semiBold,),
//               SizedBox(height: 10.h,),
//               TextFormCustom(lable: "Tiêu đề", hint: "(Tiêu đề)", error: "Vui lòng nhập tiêu đề",),
//               SizedBox(height: 10.h,),
//               TextFormCustom(lable: "Mô tả chi tiết", hint: "(Mô tả chi tiết)", error: "Vui lòng nhập mô tả",),
//             ],
//           ),
//         ),
//         Seperator(height: 10.h,),
// //DIA CHI HINH ANH
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Địa chỉ & Hình ảnh",
//                 style: AppTextStyles.roboto20semiBold,),
//               SizedBox(height: 10.h,),
//               //Tên tòa/khu dân cư/ dự á
//               TextFormCustom(lable: "Tên tòa nhà / khu dân cư / dự án ", hint:"(Không bắt buộc)", compulsory: false, ),
//               SizedBox(height: 10.h,),
//               //Địa chỉ
//               GestureDetector(
//                   onTap: (){
//                     Get.to(PostAddressScreen());
//                   },
//                   child: Container(
//                     child: TextFormField(
//                       enabled: false,
//                       decoration: InputDecoration(
//                         hintText: "Địa chỉ",
//                         hintStyle: AppTextStyles.roboto16regular.copyWith(color: AppColors.grey),
//                         disabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(5.r)),
//                           borderSide:const BorderSide(color: Colors.grey),),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(5.r)),
//                             borderSide:const BorderSide(color: Colors.grey)
//                         ),
//                       ),
//                     ),
//                   )
//               ),
//             ],
//           ),
//         ),
//         DottedBorder(
//           radius: Radius.circular(5.r),
//           strokeWidth: 1,
//           dashPattern: [5,2],
//           color: AppColors.primaryColor,
//           child: Container(
//             margin: EdgeInsets.symmetric(vertical: 10.h),
//             width: MediaQuery.of(context).size.width - 20.w,
//             height: 50.h,
//             child: Center(
//               child: Image(
//                 image: AssetImage(
//                     "assets/images/add_photo_alternate.png"
//                 ),
//               ),
//             ),
//           ),
//
//         ),
//         SizedBox(height: 10.h,),
//         Seperator(height: 10.h,),
// //DIỆN TÍCH VÀ GIÁ
//         Seperator(height: 10.h,),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Diện tích & Giá",
//                 style: AppTextStyles.roboto20semiBold,),
//               SizedBox(height: 10.h,),
//               TextFormCustom(lable: "Diện tích", hint: "(Diện tích)", error: "Vui lòng nhập diện tích",),
//               SizedBox(height: 10.h,),
//               TextFormCustom(lable: "Giá", hint: "(Giá)", error: "Vui lòng nhập giá",),
//               SizedBox(height: 10.h,),
//               TextFormCustom(lable: "Số tiền cọc", hint: "(Không bắt buộc)", compulsory: false,),
//             ],
//           ),
//         ),
//         SizedBox(height: 10,),
//         Seperator(height: 10.h,),
// //THÔNG TIN KHÁC
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Thông tin khác",
//                 style: AppTextStyles.roboto20semiBold,),
//               SizedBox(height: 10.h,),
//
//                Column(
//                   children: [
//                     DropdownButtonFormField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(5.r)),
//                             borderSide:const BorderSide(color: Colors.black)
//                         ),
//                       ),
//                       hint: Text("Tình trạng nội thất", style: AppTextStyles.roboto16regular,),
//                       items: postcontroller.propertyTypeList.map((String value) {
//                         return DropdownMenuItem(
//                           value: value,
//                           child: Text(value, style: AppTextStyles.roboto16regular,),
//                         );
//                       }).toList(),
//                       onChanged: (String? value) {
//                         int i = postcontroller.propertyTypeList.indexOf(value!);
//                       },
//                     ),
//                     SizedBox(height: 10.h,),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
