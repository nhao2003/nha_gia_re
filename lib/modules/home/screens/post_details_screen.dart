import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/global_widgets/infor_card.dart';
import 'package:nha_gia_re/modules/home/widgets/carousel_ad.dart';
import 'package:nha_gia_re/modules/home/widgets/expandable_container.dart';

final List<String> imgList = [
  'https://picsum.photos/412/240?random=1',
  'https://picsum.photos/412/240?random=13',
  'https://picsum.photos/412/240?random=11',
  'https://picsum.photos/412/240?random=12',
  'https://picsum.photos/412/240?random=3',
];

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key, required this.title});
  final String title;

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          CarouselAd(imgList: imgList, aspectRatio: 1.72, indicatorSize: 8),
          Container(
            padding: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.title,
                style: AppTextStyles.roboto20semiBold,
              ),
              Row(
                children: [
                  Text(
                    '4,3 triệu/tháng',
                    style: AppTextStyles.roboto20semiBold
                        .copyWith(color: AppColors.red),
                  ),
                  Text(' - 30m2', style: AppTextStyles.roboto20regular),
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
                        'Cầu Tỉnh Lộ 9, Xã Mỹ Hạnh Nam, Huyện Đức Hòa, Long An',
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
                    DateTime(2021, 12, 4, 5).getTimeAgo(),
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
                          'Cá nhân',
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
            title: 'Mô tả',
            minHeight: 114,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Text(
                'Chính chủ bán nhà sổ hồng riêng đã hoàn công Đường Giồng Lớn, Mỹ Hạnh Nam, Đức Hoà Long An. Cách chợ và UBND 300m, về Quận 12, Hóc Môn rất gần Diện tích: 5x15 có sân 3m Nhà 1 trệt 1 lầu, 2 phòng ngủ, 2 wc, phòng khách và bếp rất rộng, tủ bếp trên dưới, có ban công. Nhà hoàn thiện đầy đủ nội thất bằng gỗ tự nhiên, chỉ xách vali vào ở Đặc Biệt SỔ HỒNG RIÊNG ĐÃ HOÀN CÔNG, cam kết không quy hoạch, bao kiểm tra thoải mái. Xe oto vào tận nơi Giá 1,5 tỷ còn thương lượng',
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
                  Icon(Icons.phone_in_talk_outlined, size: 24,color: Colors.white,),
                  Text('Gọi điện',style: AppTextStyles.roboto12regular.copyWith(color: Colors.white),)
                ]

            )
          )),
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.messCircle, width: 24,color: AppColors.green,),
                  Text('Chat',style: AppTextStyles.roboto12regular.copyWith(color: AppColors.green),)
                ]
            )
          )),
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sms_outlined, size: 24,color: AppColors.green,),
                  Text('Tin nhắn sms',style: AppTextStyles.roboto12regular.copyWith(color: AppColors.green),)
                ]
            )
          ))
        ]),
      )),
    );
  }
}
