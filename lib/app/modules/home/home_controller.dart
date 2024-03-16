import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_mobile_itae/app/core/config/network/exceptions/api_exception.dart';
import 'package:test_mobile_itae/app/core/values/text_styles.dart';
import 'package:test_mobile_itae/app/data/model/task_model.dart';
import 'package:test_mobile_itae/app/theme/app_colors.dart';

import '../../data/local/preference_manager.dart';
import '../../data/repository/mockup_repository.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  final MockupRepository _repository = Get.find<MockupRepository>();
  final PreferenceManager _preferenceManager = Get.find<PreferenceManager>();

  late SharedPreferences prefs;

  RxBool isLoading = false.obs;
  List<TaskModel> tasks = [];
  String filterBy = 'all';

  @override
  void onReady() {
    super.onReady();

    _init();
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    await loadList();
    await _preferenceManager.setTasks(tasks);
  }

  Future<void> loadList() async {
    try {
      isLoading.value = true;

      tasks = await _repository.getTasks();

      update();
      isLoading.value = false;
    } catch (e) {
      String errorMessage = 'Error inesperado';
      if (e is ApiException) {
        errorMessage = e.message;
      }
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(
          errorMessage,
          style: MyTextStyles.title(Get.context!),
        ),
        backgroundColor: AppColors.errorColor,
      ));
    }
  }

  Future<void> refreshList() async {
    await _preferenceManager.clear();
    await loadList();
    await _preferenceManager.setTasks(tasks);
  }

  Future<void> changeFilter(String? priorityValue) async {
    if (priorityValue == null) return;

    isLoading.value = true;
    filterBy = priorityValue;
    update(['radio-group']);

    await Future.delayed(const Duration(milliseconds: 500)); // simulate  delay

    List<TaskModel> originalList = await _preferenceManager.getTasks();
    if (priorityValue == 'all') {
      tasks = originalList;
    } else {
      tasks = originalList
          .where((element) => _filterListByPriority(filterBy, element))
          .toList();
    }
    update();
    isLoading.value = false;
  }

  bool _filterListByPriority(String filterBy, TaskModel task) {
    final priorityValue = task.priority.split(" ")[1].trim();
    if (filterBy == 'high') {
      return _isHighPriority(priorityValue);
    }
    if (filterBy == 'medium') {
      return _isMediumPriority(priorityValue);
    }
    return _isLowPriority(priorityValue);
  }

  Future<void> confirmToDeleteTask(TaskModel task) async {
    final resp = await Get.defaultDialog(
      title: "Confirmación",
      middleText: "¿Estás seguro de continuar?",
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text(
            "No",
            style:
                MyTextStyles.subtitle(Get.context!).copyWith(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: Text(
            "Sí",
            style: MyTextStyles.subtitle(Get.context!)
                .copyWith(color: Colors.green),
          ),
        ),
      ],
    ).then((value) {
      if (value != null && value) {
        return 1;
      }
      return -1;
    });

    if (resp < 1) return;

    await deleteTask(task);
  }

  Future<void> deleteTask(TaskModel task) async {
    isLoading.value = true;
    List<TaskModel> originalList = await _preferenceManager.getTasks();

    originalList.removeWhere((element) => element.id == task.id);

    await _preferenceManager.setTasks(originalList);
    await changeFilter(filterBy);

    isLoading.value = false;

    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(
        'Eliminado con exito',
        style: MyTextStyles.title(Get.context!),
      ),
      backgroundColor: AppColors.sucessColor,
    ));
  }

  // categorized the priority value to high/ medium / low
  bool _isHighPriority(String prioriry) => ["1", "2", "3"].contains(prioriry);
  bool _isMediumPriority(String prioriry) =>
      ["4", "5", "6", "7"].contains(prioriry);
  bool _isLowPriority(String prioriry) => ["8", "9", "10"].contains(prioriry);
}
