import 'package:get/get.dart';
import 'package:test_mobile_itae/app/data/model/task_model.dart';
import 'package:test_mobile_itae/app/data/remote/mockup_data_source.dart';
import 'package:test_mobile_itae/app/data/repository/mockup_repository.dart';

class MockupRepositoryImpl implements MockupRepository {
  final MockupDataSource _remoteSource = Get.find<MockupDataSource>();

  @override
  Future<List<TaskModel>> getTasks() => _remoteSource.getTasks();
}
