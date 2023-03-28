import 'package:get/get.dart';

class SearchController extends GetxController {
  /// list dummy data
  final List<String> dummydata = ["nha 3 tang", "nha lau", "nha tro"];

  /// data in search delegate
  final List<String> history = <String>['apple', 'hello', 'world', 'flutter'];

  /// list suggestions in search
  RxList<String> suggestions = <String>[].obs;

  /// Name of screen
  String sreenName = 'Tìm kiếm';

  /// hint text int textField
  final String hintText = "Mua bán văn phòng";

  /// add new query to history
  void addToHistory(String newQuery) {
    if (newQuery == "") return; // should not be null
    // check in history has newQuery, if had => delete and add in the top
    if (checkIsInHistory(newQuery)) deleteHistory(newQuery);
    // add to history
    history.insert(0, newQuery);
  }

  /// check is in history has newQuery
  bool checkIsInHistory(String query) {
    for (String q in history) {
      if (q == query) return true;
    }
    return false;
  }

  /// delete a query in history
  void deleteHistory(String query) {
    history.remove(query);
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    // update suggestion to sync
    updateSuggestions(query);
  }

  /// get list Suggestions
  Iterable<String> getSuggestions(String query) {
    return query.isEmpty
        ? history
        : dummydata.where((word) => word.startsWith(query));
  }

  /// update suggestions
  void updateSuggestions(String query) {
    suggestions = [...getSuggestions(query)].obs;
  }
}
