import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/global_widgets/infor_card.dart';
import 'package:nha_gia_re/global_widgets/user_name_widget.dart';
import 'package:nha_gia_re/modules/personal/personal_controller.dart';

import '../../../core/theme/app_colors.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final PersonalController _controller = Get.find<PersonalController>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(411, 683));
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _controller.userInfo = snapshot.data!;
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              title: Text('Account'.tr),
            ),
            body: Column(children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100.w,
                          height: 100.w,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(_controller.userInfo.avatarUrl!),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UsernameWithTickLabel(
                              labelSize: 18,
                              _controller.userInfo.fullName!,
                              style: AppTextStyles.roboto20semiBold.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${_controller.userInfo.numOfFollowers} ${'Followers'.tr}",
                                  style: AppTextStyles.roboto12semiBold,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  "${_controller.userInfo.numOfFollowings} ${'Following'.tr}",
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
                            if (!_controller.check())
                              Obx(() => ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          (_controller.isFollowing.value)
                                              ? MaterialStateProperty.all(
                                                  AppColors.grey)
                                              : null,
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  onPressed: _controller.handleFollowUser,
                                  child: Row(
                                    children: [
                                      (!_controller.isFollowing.value)
                                          ? const Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.white,
                                              size: 20,
                                            )
                                          : const ImageIcon(
                                              AssetImage(Assets.delete),
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        (!_controller.isFollowing.value)
                                            ? 'Follow'.tr
                                            : 'Unfollow'.tr,
                                        style: AppTextStyles.roboto14regular
                                            .copyWith(color: Colors.white),
                                      )
                                    ],
                                  )))
                            else
                              InkWell(
                                onTap: _controller.navToUserProfile,
                                child: Container(
                                  height: 25.h,
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
                                        "Edit Profile".tr,
                                        style: AppTextStyles.roboto14semiBold
                                            .copyWith(color: Colors.black),
                                      ),
                                      SizedBox(width: 10.w,)
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
                        Expanded(
                          child: Text(
                            _controller.userInfo.address.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.roboto14regular,
                          ),
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
                          "${'Join date:'.tr} ${DateFormat('dd-MM-yyyy').format(_controller.userInfo.createdDate!)}",
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final List<Post> data = snapshot.data!;
                    return InforCardList(
                      title: 'Posted Properties'.tr,
                      list: data,
                      navType: TypeNavigate.user,
                      uid: _controller.userInfo.uid,
                    );
                  }
                },
                future: _controller.getPosts(),
              ),
            ]),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: _controller.init(Get.arguments),
    );
  }
}
