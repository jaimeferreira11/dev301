import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:test_mobile_itae/app/data/model/task_model.dart';

import '../../core/config/dio_config.dart';
import '../../core/config/network/dio_error_handler.dart';
import 'mockup_data_source.dart';

class MockupDataSourceImpl extends MockupDataSource {
  final DioService _dio = Get.find<DioService>();

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final res = await _dio.client.get('v1/task');

      return TaskModel.fromJsonList(res.data);
    } on DioException catch (dioError) {
      throw DioErrorHandler.handleDioError(dioError);
    } catch (e) {
      print(e); // TODO: Implementar un logger global
      rethrow;
    }
  }
}
