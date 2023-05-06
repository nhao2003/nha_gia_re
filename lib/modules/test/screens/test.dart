import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/enums/enums.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source_impl.dart';
import 'package:nha_gia_re/data/repositories/post_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/properties/post.dart';
import '../../../data/providers/remote/request/filter_request.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  PostRepository repository = PostRepository();
  RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final  datas = await remoteDataSourceImpl.getAllApartments(ApartmentFilter(
                  textSearch: null,
                  orderBy: OrderBy.createdAtAsc,
                  from: 0,
                  to: 10,
                  minPrice: 0,
                  maxPrice: 30000000,
                  minArea: 0,
                  maxArea: 10000,
                  postedBy: PostedBy.proSeller,
              mainDoorDirections: [Direction.south, Direction.east]));
              print(datas);
              print(datas.map((e) => e['title']));
            },
            child: Text("Get all post"),
          ),
        ));
  }
}
