import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/domain/data_provider/box_manager.dart';
import 'package:todo_list/domain/entity/task.dart';
import 'package:todo_list/ui/navigation/main_navigation.dart';
import 'package:todo_list/ui/widget/tasks/tasks_widget.dart';

class TasksWidgetModel extends ChangeNotifier {
  TaskWidgetConfiguration configuration;
  late Future<Box<Task>> _box;

  var _tasks = <Task>[];

  List<Task> get tasks => _tasks;
  TasksWidgetModel({required this.configuration}) {
    _init();
  }

  void _readTasks() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  void _initTasks() async {
    final box = await _box;
    _readTasks();
    box.listenable().addListener(_readTasks);
  }

  void deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);
  }

  void doneToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
  }

  void _init() {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);
    _initTasks();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.taskForm, arguments: configuration.groupKey);
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );
  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}
