import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({Key? key}) : super(key: key);

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  Future<String> getTextData() async {
    String url =
        'https://plo.vn/cuu-pho-cuc-truong-cuc-thue-tphcm-nguyen-thi-bich-hanh-bi-phat-4-nam-tu-post740211.html';
    var response = await get(Uri.parse(url));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getTextData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Html(
                data: snapshot.data,
                onLinkTap: (url, _, __) async {
                  print("Opening $url...");
                  await launchUrl(
                    Uri.parse(url!),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //     child: Column(
    //       children: [
    //         Text(
    //           "Cựu phó cục trưởng Cục Thuế TP.HCM Nguyễn Thị Bích Hạnh bị phạt 4 năm tù",
    //           style: Theme.of(context)
    //               .textTheme
    //               .headlineSmall!
    //               .copyWith(fontWeight: FontWeight.bold),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           "(PLO)- Với cáo buộc ký các quyết định hoàn thuế trái quy định gây thất thoát 331 tỉ đồng, cựu phó Cục trưởng Cục Thuế TP.HCM Nguyễn Thị Bích Hạnh bị phạt bốn năm tù.",
    //           style: Theme.of(context).textTheme.titleMedium,
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           children: const [
    //             Text(
    //               "Nhật Hào",
    //               style: TextStyle(fontWeight: FontWeight.bold),
    //             ),
    //             SizedBox(
    //               width: 5,
    //             ),
    //             Icon(Icons.watch_later_outlined),
    //             SizedBox(
    //               width: 5,
    //             ),
    //             Text("12:03 30/06/2023")
    //           ],
    //         ),
    //
    //         FutureBuilder(
    //           future: getTextData(),
    //           builder: (context, snapshot) {
    //             if (snapshot.hasData) {
    //               return Container(
    //                 child: Html(
    //                   data: snapshot.data,
    //                   onLinkTap: (url, _, __) async {
    //                     print("Opening $url...");
    //                     await launchUrl(
    //                       Uri.parse(url!),
    //                       mode: LaunchMode.externalApplication,
    //                     );
    //                   },
    //                 ),
    //               );
    //             }
    //             return CircularProgressIndicator();
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
