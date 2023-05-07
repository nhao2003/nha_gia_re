import 'package:nha_gia_re/data/models/address.dart';
import '../enums/enums.dart';
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
