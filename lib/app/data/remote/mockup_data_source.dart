import 'package:test_mobile_itae/app/data/model/task_model.dart';

abstract class MockupDataSource {
  Future<List<TaskModel>> getTasks();
}
