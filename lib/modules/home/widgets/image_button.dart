import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/home/home_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// ignore: must_be_immutable
class ImageButton extends StatefulWidget {
  int index;
  String province;
  ImageButton(this.index, this.province, {super.key});

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: GestureDetector(
        onTap: () {
          // do something when the image is tapped
          controller.navByProvince(widget.province);
        },
        child: Stack(
          children: [
            Container(
              width: 124,
              height: 124,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://picsum.photos/412/240?random=${widget.index}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    widget.province,
                    style: AppTextStyles.roboto16semiBold
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
