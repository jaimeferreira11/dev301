import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_mobile_itae/app/core/values/spaces.dart';
import 'package:test_mobile_itae/app/core/values/text_styles.dart';
import 'package:test_mobile_itae/app/modules/home/local_widgets/task_item.dart';
import 'package:test_mobile_itae/app/modules/home/local_widgets/tasks_filters.dart';
import 'package:test_mobile_itae/app/routes/app_routes.dart';
import 'package:test_mobile_itae/app/ui/global_widgets/custom_appbar.dart';
import 'package:test_mobile_itae/app/ui/global_widgets/custom_progress.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (_) => SafeArea(
              child: Scaffold(
                appBar: const CustomAppBar(titulo: 'Lista de tareas'),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => Get.toNamed(AppRoutes.form),
                  heroTag: 'add',
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                body: SafeArea(
                    child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: MySpaces.marginVertical(context),
                        ),
                        Text(
                          'Filtrar por prioridad: ',
                          style: MyTextStyles.subtitle(context),
                        ),
                        const TaskFilter(),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => _.refreshList(),
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (__, int index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MySpaces.marginHorizontal(context)),
                                    child: TaskItem(task: _.tasks[index])),
                                itemCount: _.tasks.length),
                          ),
                        ),
                      ],
                    ),
                    CustomProgress(isLoading: _.isLoading)
                  ],
                )),
              ),
            ));
  }
}
