import '../model/task_model.dart';

abstract class PreferenceManager {
  static const keyTasks = "tasks";

  Future<List<TaskModel>> getTasks();

  Future<bool> setTasks(List<TaskModel> tasks);

  Future<bool> clear();
}
