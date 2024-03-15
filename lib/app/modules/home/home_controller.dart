import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_mobile_itae/app/core/config/network/exceptions/api_exception.dart';
import 'package:test_mobile_itae/app/core/values/text_styles.dart';
import 'package:test_mobile_itae/app/data/model/task_model.dart';
import 'package:test_mobile_itae/app/theme/app_colors.dart';

import '../../data/repository/mockup_repository.dart';

class HomeController extends GetxController {
  final MockupRepository _repository = Get.find<MockupRepository>();

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
    await saveListInLocalStorage(tasks);
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

// TODO: Move to local repository
  Future<void> saveListInLocalStorage(List<TaskModel> list) async {
    final jsonList = list.map((item) => item.toJson()).toList();
    await prefs.setString('tasks', jsonEncode(jsonList));
  }

  Future<List<TaskModel>> getTaskListFromLocalStorage() async {
    final jsonString = prefs.getString('tasks');
    if (jsonString == null) return [];

    return TaskModel.fromJsonList(jsonDecode(jsonString));
  }

  Future<void> changeFilter(String? priorityValue) async {
    if (priorityValue == null) return;

    isLoading.value = true;
    filterBy = priorityValue;
    update(['radio-group']);

    await Future.delayed(const Duration(milliseconds: 500)); // simulate  delay

    List<TaskModel> originalList = await getTaskListFromLocalStorage();
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

  // categorized the priority value to high/ medium / low
  bool _isHighPriority(String prioriry) => ["1", "2", "3"].contains(prioriry);
  bool _isMediumPriority(String prioriry) =>
      ["4", "5", "6", "7"].contains(prioriry);
  bool _isLowPriority(String prioriry) => ["8", "9", "10"].contains(prioriry);

  Future<void> deleteTask(TaskModel task) async {
    // TODO: Mover a servicio global
    final resp = await Get.defaultDialog(
      title: "Confirmación",
      middleText: "¿Estás seguro de continuar?",
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: false); // Usuario no está seguro
          },
          child: Text(
            "No",
            style:
                MyTextStyles.subtitle(Get.context!).copyWith(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true); // Usuario está seguro
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

// borrar
    isLoading.value = true;
    List<TaskModel> originalList = await getTaskListFromLocalStorage();

    originalList.removeWhere((element) => element.id == task.id);

    await saveListInLocalStorage(originalList);
    await changeFilter(filterBy);

    isLoading.value = false;
  }
}
