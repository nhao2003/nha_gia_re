import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/extensions/integer_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/data/models/properties/post.dart';
import 'package:nha_gia_re/global_widgets/infor_card.dart';
import 'package:nha_gia_re/modules/home/widgets/carousel_ad.dart';
import 'package:nha_gia_re/modules/home/widgets/expandable_container.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key, required this.post});
  final Post post;

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          CarouselAd(imgList: widget.post.imagesUrl, aspectRatio: 1.72, indicatorSize: 8),
          Container(
            padding: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.post.title,
                style: AppTextStyles.roboto20semiBold,
              ),
              Row(
                children: [
                  Text(
                    widget.post.price.toFormattedMoney(isLease: widget.post.isLease),
                    style: AppTextStyles.roboto20semiBold
                        .copyWith(color: AppColors.red),
                  ),
                  Text(' - ${widget.post.area}m2', style: AppTextStyles.roboto20regular),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                      )),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    Assets.map_pin,
                    width: 24,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      width: 320,
                      child: Text(
                        widget.post.address.toString(),
                        maxLines: 2,
                        style: AppTextStyles.roboto16regular,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Image.asset(
                    Assets.clock,
                    width: 24,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.post.postedDate.getTimeAgo(),
                    style: AppTextStyles.roboto16regular,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('https://picsum.photos/50'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nhật Hào',
                          style: AppTextStyles.roboto16semiBold,
                        ),
                        Text(
                          (widget.post.isProSeller) ? "Môi giới": "Cá nhân",
                          style: AppTextStyles.roboto14regular,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text('Xem hồ sơ'),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: AppColors.primaryColor))))),
                ],
              ),
            ]),
          ),
          ExpandableContainer(
            title: 'Gần bạn',
            minHeight: 110,
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 3,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(Assets.room_num, width: 24,),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text('Số phòng ngủ: 2 phòng', style: AppTextStyles.roboto14regular, maxLines: 2,)),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(Assets.paper, width: 24,),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text('Giấy tờ pháp lý: Đã có sổ', style: AppTextStyles.roboto14regular,)),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(Assets.area, width: 24,),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text('Diện tích đất: 75 m2', style: AppTextStyles.roboto14regular, maxLines: 2,)),
                    ],
                  ),
                  
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(Assets.home_type, width: 24,),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text('Loại hình nhà ở: Nhà mặt phố', style: AppTextStyles.roboto14regular,)),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(Assets.width, width: 24,),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text('Chiều ngang: 5m', style: AppTextStyles.roboto14regular, maxLines: 2,)),
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(Assets.floor, width: 24,),
                      SizedBox(width: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Text('Tổng số tầng: 1', style: AppTextStyles.roboto14regular,)),
                    ],
                  ),                
                ],
              )
            ),
          ),
          ExpandableContainer(
            title: 'Mô tả',
            minHeight: 114,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Text(
                widget.post.description,
                style: AppTextStyles.roboto16regular,
              ),
            ),
          ),
          InforCardList(title: 'Liên Quan', list: [])
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
          child: SizedBox(
        height: 80,
        child: Row(children: [
          Expanded(
              child: MaterialButton(
                  onPressed: () {},
                  color: AppColors.green,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone_in_talk_outlined,
                          size: 24,
                          color: Colors.white,
                        ),
                        Text(
                          'Gọi điện',
                          style: AppTextStyles.roboto12regular
                              .copyWith(color: Colors.white),
                        )
                      ]))),
          Expanded(
              child: MaterialButton(
                  onPressed: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.messCircle,
                          width: 24,
                          color: AppColors.green,
                        ),
                        Text(
                          'Chat',
                          style: AppTextStyles.roboto12regular
                              .copyWith(color: AppColors.green),
                        )
                      ]))),
          Expanded(
              child: MaterialButton(
                  onPressed: () {},
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sms_outlined,
                          size: 24,
                          color: AppColors.green,
                        ),
                        Text(
                          'Tin nhắn sms',
                          style: AppTextStyles.roboto12regular
                              .copyWith(color: AppColors.green),
                        )
                      ])))
        ]),
      )),
    );
  }
}
