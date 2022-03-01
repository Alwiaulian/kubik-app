import 'package:hive_flutter/hive_flutter.dart';

class FlutterNoSql extends Object {
  static bool _isInitial = false;
  static const String _boxName = 'FlutterNoSqlKubik';
  static const String _errorMessage = 'FlutterNoSql is not initial...\nplease call FlutterNoSql.initFlutter() before CURD data';


  static Future initFlutter() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
    _isInitial = true;
  }

  static bool _checkInitial() {
    if (!_isInitial) print(_errorMessage);
    return _isInitial;
  }

  static saveToken(String token) async{
    if (_checkInitial() == false) return;
    var box = Hive.box(_boxName);
    box.put('token', token);
  }

  static String? getToken() {
    if (_checkInitial() == false) return null;
    var box = Hive.box(_boxName);
    return box.get('token');
  }

  static void clearToken() {
    if (_checkInitial() == false) return;
    var box = Hive.box(_boxName);
    box.delete("token");
  }


  static saveJsonString({String? key, String? json}) async{
    assert(key != null && json != null);
    if (_checkInitial() == false) return;
    var box = Hive.box(_boxName);
    box.put(key, json);
  }

  static String getJsonString({String? key}) {
    assert(key != null);
    if (_checkInitial() == false) return '';
    var box = Hive.box(_boxName);
    String res = box.get(key);
    return res;
  }

  static void clearJsonString({String? key}) {
    if (_checkInitial() == false) return;
    var box = Hive.box(_boxName);
    box.delete(key);
  }

  static saveJsonBicaraCepat({String? key, String? json}) async{
    assert(key != null && json != null);
    if (_checkInitial() == false) return;
    var box = Hive.box(_boxName);
    box.put(key, json);
  }
  static String getJsonBicaraCepat({String? key}) {
    assert(key != null);
    if (_checkInitial() == false) return '';
    var box = Hive.box(_boxName);
    String res = box.get(key);
    return res;
  }
  static void clearJsonBicaraCepat({String? key}) {
    if (_checkInitial() == false) return;
    var box = Hive.box(_boxName);
    box.delete(key);
  }
  
  static saveJsonFrase({String? key, String? json}) async{
    assert(key != null && json != null);
    if (_checkInitial() == false) return;
    var box = Hive.box(_boxName);
    box.put(key, json);
  }
  static String getJsonFrase({String? key}) {
    assert(key != null);
    if (_checkInitial() == false) return '';
    var box = Hive.box(_boxName);
    String res = box.get(key);
    return res;
  }
  static void clearJsonFrase({String? key}) {
    if (_checkInitial() == false) return;
    var box = Hive.box(_boxName);
    box.delete(key);
  }
}