import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/global_widgets/infor_card.dart';
import 'package:nha_gia_re/modules/personal/personal_controller.dart';

import '../../../core/theme/app_colors.dart';

class PersonalScreen extends StatefulWidget {
  PersonalScreen({Key? key}) : super(key: key);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final PersonalController _controller = Get.find<PersonalController>();

  @override
  void initState() {
    _controller.init(Get.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(411, 683));
    if(_controller.userInfo == null)
      return Center(child: Text("Null"),);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(_controller.userInfo!.fullName??"NULL"),
      ),
      body: Container(
        //padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Column(children: [
          Container(
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
                        backgroundImage:
                            NetworkImage(_controller.userInfo!.avatarUrl!),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _controller.userInfo!.fullName!,
                          style: AppTextStyles.roboto20semiBold,
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${_controller.userInfo!.numOfFollowers} Người theo dõi",
                              style: AppTextStyles.roboto12semiBold,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              "${_controller.userInfo!.numOfFollowings} Đang theo dõi",
                              style: AppTextStyles.roboto12semiBold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
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
                        if (!_controller.isYourSelf)
                          if (!_controller.isFollowing)
                            ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'Theo dõi',
                                      style: AppTextStyles.roboto14regular
                                          .copyWith(color: Colors.white),
                                    )
                                  ],
                                ))
                          else
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.grey),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    const ImageIcon(
                                      AssetImage(Assets.delete),
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'Bỏ theo dõi',
                                      style: AppTextStyles.roboto14regular
                                          .copyWith(color: Colors.white),
                                    )
                                  ],
                                ))
                        else
                          InkWell(
                            onTap: _controller.navToUserProfile,
                            child: Container(
                              height: 25.h,
                              width: 195.w,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(1, 1.1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20.r),
                                color: AppColors.backgroundColor,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: 30.w,
                                      child: Center(
                                          child: Icon(
                                        color: Colors.black,
                                        Icons.edit_outlined,
                                        size: 15.h,
                                      ))),
                                  Text(
                                    "Chỉnh sửa trang cá nhân",
                                    style: AppTextStyles.roboto14semiBold
                                        .copyWith(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                        size: 20.w,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      _controller.userInfo!.address.toString(),
                      style: AppTextStyles.roboto14regular,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      child: Icon(
                        Icons.date_range_outlined,
                        color: Colors.black,
                        size: 20.w,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Ngày tham gia: ${DateFormat('dd-MM-yyyy').format(_controller.userInfo!.createdDate!)}",
                      style: AppTextStyles.roboto14regular,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 10.h,
            color: AppColors.backgroundColor,
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final List<Post> data = snapshot.data!;
                return InforCardList(title: 'Tin đã đăng', list: data);
              }
            },
            future: _controller.getPosts(),
          ),
        ]),
      ),
    );
  }
}
