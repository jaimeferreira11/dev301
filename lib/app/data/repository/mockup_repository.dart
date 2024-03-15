import 'package:test_mobile_itae/app/data/model/task_model.dart';

abstract class MockupRepository {
  Future<List<TaskModel>> getTasks();
}
