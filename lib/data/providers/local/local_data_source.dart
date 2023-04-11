import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalDataSource {
  void setUserToken(String token);
  void clearCache(String key);
}

class LocalDataSourceImpl extends LocalDataSource {
  @override
  void clearCache(String key) async {}

  @override
  Future<void> setUserToken(String token) async {}
}
