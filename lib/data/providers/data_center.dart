import '../models/properties/post.dart';

class DataCenter {
  static final DataCenter instance = DataCenter._internal();

  factory DataCenter() {
    return instance;
  }

  DataCenter._internal();

  List<Post> listPosts = [

  ];
}
