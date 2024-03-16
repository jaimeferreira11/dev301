import 'package:get/get.dart';

import '../../../data/local/preference_manager.dart';
import '../../../data/local/preference_manager_impl.dart';
import '../../../data/remote/mockup_data_source.dart';
import '../../../data/remote/mockup_data_source_impl.dart';
import '../../../data/repository/mockup_repository.dart';
import '../../../data/repository/mockup_repository_impl.dart';
import '../dio_config.dart';

class DependecyInjection {
  static Future<void> init() async {
    Get.lazyPut<DioService>(
      () => DioService(),
      fenix: true,
    );

    Get.lazyPut<MockupRepository>(() => MockupRepositoryImpl(), fenix: true);
    Get.lazyPut<MockupDataSource>(() => MockupDataSourceImpl(), fenix: true);
    Get.lazyPut<PreferenceManager>(() => PreferenceManagerImpl(), fenix: true);
  }
}
