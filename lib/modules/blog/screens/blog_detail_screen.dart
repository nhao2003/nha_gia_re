import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:nha_gia_re/core/extensions/date_ex.dart';
import 'package:nha_gia_re/modules/blog/blog_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/blog.dart';

class BlogDetailScreen extends StatefulWidget {
  const BlogDetailScreen({Key? key}) : super(key: key);

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  Future<String> getTextData() async {
    return r""" 
    <!DOCTYPE html>
<html>
<head>
    <title>Mẫu HTML</title>
</head>
<body>
    <h1>Heading 1</h1>
    <h2>Heading 2</h2>
    <h3>Heading 3</h3>
    
    <p>Đây là một đoạn văn bản thường.</p>
    
    <img src="https://picsum.photos/200/300?random=1" alt="Ảnh ngẫu nhiên 1" width="200" height="300">
    
    <img src="https://picsum.photos/200/300?random=2" alt="Ảnh ngẫu nhiên 2" width="200" height="300">
    
    <a href="https://example.com">Đây là một liên kết đến Example.com</a>
    
    <table>
        <tr>
            <th>Tiêu đề cột 1</th>
            <th>Tiêu đề cột 2</th>
        </tr>
        <tr>
            <td>Dữ liệu hàng 1, cột 1</td>
            <td>Dữ liệu hàng 1, cột 2</td>
        </tr>
        <tr>
            <td>Dữ liệu hàng 2, cột 1</td>
            <td>Dữ liệu hàng 2, cột 2</td>
        </tr>
    </table>
</body>
</html>

     """;
  }

  BlogController _controller = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _controller.initBlog(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Blog blog = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      blog.shortDescription,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          blog.author,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(Icons.watch_later_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(blog.createAt.getTimeAgo())
                      ],
                    ),
                    Html(
                      data: blog.content,
                      onLinkTap: (url, _, __) async {
                        print("Opening $url...");
                        await launchUrl(
                          Uri.parse(url!),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
