import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_mobile_itae/app/data/local/preference_manager.dart';
import 'package:test_mobile_itae/app/data/model/task_model.dart';
import 'package:test_mobile_itae/app/modules/home/home_controller.dart';
import 'package:uuid/uuid.dart';

import '../../core/values/text_styles.dart';
import '../../theme/app_colors.dart';

class FormController extends GetxController {
  final PreferenceManager _preferenceManager = Get.find<PreferenceManager>();

  RxBool isLoading = true.obs;
  RxBool isProcess = false.obs;

  TaskModel? taskToSave;

  FormGroup? form;

  final List<String> priorities = [
    'Prioridad 1',
    'Prioridad 2',
    'Prioridad 3',
    'Prioridad 4',
    'Prioridad 5',
    'Prioridad 6',
    'Prioridad 7',
    'Prioridad 8',
    'Prioridad 9',
    'Prioridad 10'
  ];
  String initialPriority = 'Prioridad 1';
  @override
  void onReady() {
    super.onReady();
    _init();
  }

  Future<void> _init() async {
    final args = Get.arguments;
    if (args != null) {
      taskToSave = TaskModel.fromJson(args);
      initialPriority = _translatePriorityToSpanish(taskToSave!.priority);
    }
    initForm();
    update();

    isLoading.value = false;
  }

  void initForm() {
    form = FormGroup({
      'title': FormControl(
        value: taskToSave?.title,
        validators: [
          Validators.required,
        ],
      ),
      'description': FormControl(
        value: taskToSave?.description,
        validators: [
          Validators.required,
        ],
      ),
      'priority': FormControl(
        value: taskToSave?.priority != null
            ? _translatePriorityToSpanish(taskToSave!.priority)
            : initialPriority,
        validators: [
          Validators.required,
        ],
      ),
    });
  }

  String get title => form!.control('title').value;
  String get description => form!.control('description').value;
  String get priority => form!.control('priority').value;

  Future<void> submit() async {
    form!.markAllAsTouched();
    if (form!.invalid) return;

    isProcess.value = true;
    final data = TaskModel(
        title: title,
        description: description,
        priority: _translatePriorityToEnglish(priority),
        id: taskToSave?.id ?? const Uuid().v4());

    List<TaskModel> task = await _preferenceManager.getTasks();
    task = [data, ...task.where((e) => e.id != data.id)];
    await _preferenceManager.setTasks([...task]);

    isProcess.value = false;
    _updateAndNotify(task);
  }

  _updateAndNotify(List<TaskModel> task) {
    final homeController = Get.find<HomeController>();
    homeController.tasks = [...task];
    homeController.update();
    Get.back();

    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(
        'Guardado con exito',
        style: MyTextStyles.title(Get.context!),
      ),
      backgroundColor: AppColors.sucessColor,
    ));
  }

  String _translatePriorityToSpanish(String priority) =>
      priority.replaceAll('priority', 'Prioridad');
  String _translatePriorityToEnglish(String priority) =>
      priority.replaceAll('Prioridad', 'priority');
}
