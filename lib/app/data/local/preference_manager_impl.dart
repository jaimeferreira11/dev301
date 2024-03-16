import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_mobile_itae/app/data/model/task_model.dart';

import 'preference_manager.dart';

class PreferenceManagerImpl implements PreferenceManager {
  final _preference = SharedPreferences.getInstance();

  @override
  Future<bool> clear() {
    return _preference.then((preference) => preference.clear());
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final jsonString = await _preference
        .then((preference) => preference.getString(PreferenceManager.keyTasks));
    if (jsonString == null) return [];
    return TaskModel.fromJsonList(jsonDecode(jsonString));
  }

  @override
  Future<bool> setTasks(List<TaskModel> tasks) async {
    try {
      final jsonList = tasks.map((item) => item.toJson()).toList();
      await _preference.then((preference) => preference.setString(
          PreferenceManager.keyTasks, jsonEncode(jsonList)));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
