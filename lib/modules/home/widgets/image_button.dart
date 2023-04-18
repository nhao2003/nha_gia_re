import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';

class ImageButton extends StatefulWidget {
  const ImageButton({super.key});

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
  onTap: () {
    // do something when the image is tapped
  },
  child: Stack(
    children: [
      Container(
        width: 124,
        height: 124,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/412/240?random=2'),
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
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Colors.black.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              'Thủ Đức',
              style: AppTextStyles.roboto16semiBold.copyWith(color: Colors.white),
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