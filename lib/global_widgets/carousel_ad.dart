import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nha_gia_re/core/extensions/buildcontext_ex.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/modules/home/home_controller.dart';

class CarouselAd extends StatefulWidget {
  const CarouselAd(
      {super.key,
      required this.imgList,
      required this.aspectRatio,
      required this.indicatorSize});
  final List<String> imgList;
  final double aspectRatio;
  final double indicatorSize;

  @override
  State<CarouselAd> createState() => _CarouselAdState();
}

class _CarouselAdState extends State<CarouselAd> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Stack(
      children: [
        GestureDetector(
          onTap: () {
            homeController.launchWebURL(homeController.fakeUrl);
          },
          child: CarouselSlider(
            items: widget.imgList
                .map((item) => CachedNetworkImage(
                    imageUrl: item,
                    fit: BoxFit.cover,
                    width: context.screenSize.width))
                .toList(),
            carouselController: _controller,
            options: CarouselOptions(
              aspectRatio: widget.aspectRatio,
              viewportFraction: 1,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: widget.indicatorSize,
                  height: widget.indicatorSize,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ));
  }
}
