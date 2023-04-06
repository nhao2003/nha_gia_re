import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/core/values/assets_image.dart';
import 'package:nha_gia_re/global_widgets/infor_card.dart';
import 'package:nha_gia_re/modules/home/widgets/carousel_ad.dart';
import '../home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search...'.tr,
                  border: InputBorder.none),
            ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(Assets.messCircle, width: 24),
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: const [
          CarouselAd(),
          InforCardList(title: 'Gần bạn', list: []),
          InforCardList(title: 'Nhà bán', list: []),
          InforCardList(title: 'Nhà cho thuê', list: []),
        ],
      )),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Image.asset(Assets.edit,height: 30,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.home,height: 25,),
                    SizedBox(height: 5,),
                    Text('Home'.tr, style: AppTextStyles.roboto12regular,)
                  ]
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.post,height: 25,),
                    SizedBox(height: 5,),
                    Text('Quản lý tin'.tr, style: AppTextStyles.roboto12regular,)
                  ]
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.bell,height: 25,),
                    SizedBox(height: 5,),
                    Text('Thông báo'.tr, style: AppTextStyles.roboto12regular,)
                  ]
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.person,height: 25,),
                    SizedBox(height: 5,),
                    Text('Tài khoản'.tr, style: AppTextStyles.roboto12regular,)
                  ]
                ),
              ),
            ),
          ],
        )
      ),
    
    );
  }
}
