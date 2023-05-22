import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';

import '../../../core/theme/app_colors.dart';

class ExpandableContainer extends StatefulWidget {
  const ExpandableContainer({super.key, this.child, required this.title, required this.minHeight});
  final Widget? child;
  final String title;
  final double minHeight;

  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.6;

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppTextStyles.roboto20semiBold,
          ),
          const SizedBox(
            height: 10,
          ),
          AnimatedSize(
            vsync: this,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: widget.minHeight,
                maxHeight: isExpanded ? maxHeight : widget.minHeight,
              ),
              child: widget.child ?? const SizedBox.shrink(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider( 
            thickness: 0.5,
            height: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Text(
                  isExpanded ? 'Thu gọn' : 'Xem thêm',
                  style: AppTextStyles.roboto16regular.copyWith(
                    color: AppColors.blue,
                  ),
                ),
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });

                  if (isExpanded) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
