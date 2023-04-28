import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/enums/property_enums.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';

import '../../../data/models/properties/post.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  PostRepository repository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final List<Post> datas = await repository.getAllPosts(
                  textSearch: 'dat',
                  orderBy: OrderBy.createdAtAsc,
                  from: 0,
                  to: 10,
                  minPrice: 0,
                  maxPrice: 30000000,
                  minArea: 0,
                  maxArea: 10000,
                  postedBy: PostedBy.proSeller);
              print(datas.length);
              print(datas.map((e) => e.title).toList().toString());
            },
            child: Text("Get all post"),
          ),
        ));
  }
}
