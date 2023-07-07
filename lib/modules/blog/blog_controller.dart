import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:nha_gia_re/data/models/blog.dart';
import 'package:nha_gia_re/data/providers/remote/remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogController extends GetxController {
  Future<List<Blog>> getBlogs() async {
    final List<Map<String, dynamic>> data = await Supabase.instance.client.from('blogs').select();
    return data.map((e) => Blog.fromJson(e)).toList();
  }
  Future<void> updateViewBlog(String id)
  async {
    RemoteDataSource dataSource = RemoteDataSource();
    dataSource.updateBlogView(id);
  }
  late Blog blog;
  Future<Blog?> initBlog(arguments) async {
    if(arguments is Blog){
      blog = arguments;
      return arguments;
    }
    return null;
  }

}