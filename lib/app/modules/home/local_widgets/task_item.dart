import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_mobile_itae/app/core/values/spaces.dart';
import 'package:test_mobile_itae/app/core/values/text_styles.dart';
import 'package:test_mobile_itae/app/data/model/task_model.dart';
import 'package:test_mobile_itae/app/modules/home/home_controller.dart';
import 'package:test_mobile_itae/app/routes/app_routes.dart';
import 'package:test_mobile_itae/app/theme/app_colors.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Card(
      child: ListTile(
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(task.title, style: MyTextStyles.title(context)),
        subtitle: Text(
          task.description,
        ),
        leading: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Prioridad',
              style: MyTextStyles.small(context),
            ),
            Text(
              dataToDisplay(task.priority),
              style: MyTextStyles.title(context)
                  .copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        trailing: Wrap(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () =>
                    Get.toNamed(AppRoutes.form, arguments: task.toJson()),
              ),
            ),
            SizedBox(
              width: MySpaces.marginHorizontal(context),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () => controller.confirmToDeleteTask(task),
              ),
            )
          ],
        ),
      ),
    );
  }

  String dataToDisplay(String prioridad) => prioridad.split(" ")[1];
}
