import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  final String title;
  final String description;
  final String priority;
  final String id;

  TaskModel({
    required this.title,
    required this.description,
    required this.priority,
    required this.id,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        title: json["title"],
        description: json["description"],
        priority: json["priority"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "priority": priority,
        "id": id,
      };

  static List<TaskModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((item) => item is TaskModel ? item : TaskModel.fromJson(item))
        .toList();
  }
}
