import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MediaPageView extends StatelessWidget {
  late List<String> urls;
  late int defaultIndex;

  MediaPageView(this.urls, {super.key, this.defaultIndex = 0})
      : assert(defaultIndex <= urls.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(
        controller: PageController(initialPage: defaultIndex),
          itemCount: urls.length,
          itemBuilder: (context, index) {
            return Center(
              child: CachedNetworkImage(
                imageUrl: urls[index],
              ),
            );
          }),
    );
  }
}
