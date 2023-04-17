import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';

import '../../../core/theme/app_colors.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(411,683));
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Nhật Hào"),
      ),
      body: Container(

        //padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Column(
          children: [Container(
            color: Colors.white,

            padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
            child: Column(

              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.w,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/ava.png"
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nhật hào", style: AppTextStyles.roboto20semiBold ,),
                        SizedBox(height: 7.h,),
                        Row(
                          children: [
                            Text("69 Người theo dõi", style: AppTextStyles.roboto12semiBold,),
                            SizedBox(width: 20.w,),
                            Text("1 Đang theo dõi", style: AppTextStyles.roboto12semiBold,),
                          ],
                        ),
                        SizedBox(height: 7.h,),
                        // Container(
                        //
                        //   height: 25.h,
                        //   width: 100.w,
                        //   decoration: BoxDecoration(
                        //     boxShadow: [BoxShadow(
                        //       color: Colors.black26,
                        //       offset: Offset(1,1.1),
                        //       blurRadius: 1,
                        //       spreadRadius: 1,
                        //     ),],
                        //     borderRadius: BorderRadius.circular(20.r),
                        //     color: AppColors.primaryColor,
                        //   ),
                        //     child: Row(
                        //       children: [
                        //         SizedBox(
                        //             width: 30.w,
                        //             child: Center(child: Icon(color: Colors.white, Icons.add_circle_outline, size: 15.h,))),
                        //         Text("Theo dõi", style: AppTextStyles.roboto14semiBold.copyWith(color: Colors.white), )
                        //       ],
                        //     ),
                        //   ),

                        // Container(
                        //
                        //   height: 25.h,
                        //   width: 120.w,
                        //   decoration: BoxDecoration(
                        //     boxShadow: [BoxShadow(
                        //       color: Colors.black26,
                        //       offset: Offset(1,1.1),
                        //       blurRadius: 1,
                        //       spreadRadius: 1,
                        //     ),],
                        //     borderRadius: BorderRadius.circular(20.r),
                        //     color: Colors.black26,
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //           width: 30.w,
                        //           child: Center(child: Icon(color: Colors.white, Icons.add_circle_outline, size: 15.h,))),
                        //       Text("Bỏ Theo dõi", style: AppTextStyles.roboto14semiBold.copyWith(color: Colors.white), )
                        //     ],
                        //   ),
                        // ),
                        Container(

                          height: 25.h,
                          width: 195.w,
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                              color: Colors.black54,
                              offset: Offset(1,1.1),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),],
                            borderRadius: BorderRadius.circular(20.r),
                            color: AppColors.backgroundColor,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 30.w,
                                  child: Center(child: Icon(color: Colors.black, Icons.edit_outlined, size: 15.h,))),
                              Text("Chỉnh sửa trang cá nhân", style: AppTextStyles.roboto14semiBold.copyWith(color: Colors.black), )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15.h,),
                Row(
                  children: [
                    SizedBox(
                      child:
                      Icon(Icons.location_on_outlined, color: Colors.black, size: 20.w,),
                    ),
                    SizedBox(width: 5.w,),
                    Text("KTX Khu A, phường Linh Trung, Thủ Đức, TP Hồ Chí Minh", style: AppTextStyles.roboto14regular,),
                  ],
                ),
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    SizedBox(
                      child:
                      Icon(Icons.date_range_outlined, color: Colors.black, size: 20.w,),
                    ),
                    SizedBox(width: 5.w,),
                    Text("Ngày tham gia: 14/03/2023", style: AppTextStyles.roboto14regular,),
                  ],
                ),
                SizedBox(height: 10.h,),
              ],
            ),
          ),

            Container(
              width: double.maxFinite,
              height: 10.h,
              color: AppColors.backgroundColor,
            ),
            Container(
              height: 200.h,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tin đã đăng", style: AppTextStyles.roboto20semiBold,)
                ],
              ),
            )
          ]
        ),
      ),

    );
  }
}
