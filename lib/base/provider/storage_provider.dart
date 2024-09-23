import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageAssistantProvider with ChangeNotifier {
  SharedPreferences? _prefs;


  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<void> saveJson(String key, Map<String, dynamic> jsonData) async {
    if (_prefs == null) await init();

    String jsonString = json.encode(jsonData);
    await _prefs?.setString(key, jsonString);
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchJson(String key) async {
    if (_prefs == null) await init();

    String? jsonString = _prefs?.getString(key);
    if (jsonString != null) {
      return json.decode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }


  Future<void> removeJson(String key) async {
    if (_prefs == null) await init();

    await _prefs?.remove(key);
    notifyListeners();
  }


  Future<void> clearAll() async {
    if (_prefs == null) await init();

    await _prefs?.clear();
    notifyListeners();
  }
}
