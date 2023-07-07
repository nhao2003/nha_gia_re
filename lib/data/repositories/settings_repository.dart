import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsRepository {
  final _settingBox = Hive.box('settings');
  void saveLanguageCode(String languageCode)
  {
    debugPrint('saved ${languageCode}');
    _settingBox.put('lang', languageCode);
  }
  String? getLanguageCode(){
    debugPrint('get ${_settingBox.get('lang')}');
    return _settingBox.get('lang');
  }
}