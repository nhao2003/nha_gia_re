import 'package:get/get.dart';

class SearchController extends GetxController {
  // list dummy data
  final List<String> dummydata = ["nha 3 tang", "nha lau", "nha tro"];

  // Name of screen
  String sreenName = 'Tìm kiếm';

  // data in search delegate
  final List<String> history = <String>['apple', 'hello', 'world', 'flutter'];

  // hint text int textField
  final String hintText = "Mua bán văn phòng";
}
