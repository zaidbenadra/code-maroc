import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class SettingsProvider extends ChangeNotifier {
  final _box = Hive.box('settings');

  String get language => _box.get('language', defaultValue: 'ar') as String;
  bool   get soundOn  => _box.get('sound',    defaultValue: true)  as bool;

  void setLanguage(String lang) { _box.put('language', lang); notifyListeners(); }
  void toggleSound()            { _box.put('sound', !soundOn); notifyListeners(); }
}
