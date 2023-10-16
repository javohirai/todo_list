import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/domain/entity/group.dart';
import 'package:todo_list/domain/entity/task.dart';
import 'package:todo_list/ui/navigation/main_navigation.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late Future<Box<Group>> _groupBox;
  Group? _group;
  Group? get group => _group;

  var _tasks = <Task>[];

  List<Task> get tasks => _tasks;
  TasksWidgetModel({required this.groupKey}) {
    _init();
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _readTasks() async {
    await Hive.openBox<Task>('tasks_box');
    _tasks = _group?.tasks ?? [];
    notifyListeners();
  }

  void _initTasks() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: <dynamic>[groupKey]).addListener(_readTasks);
  }

  void deleteTask(int taskIndex) async {
    await Hive.openBox<Task>('tasks_box');
    _group?.tasks?.deleteFromHive(taskIndex);
    notifyListeners();
  }

  void doneToggle(int taskIndex) async {
    final currentState = _group?.tasks?[taskIndex].isDone ?? false;
    await Hive.openBox<Task>('tasks_box');
    _group?.tasks?[taskIndex].isDone = !currentState;
    _group?.save();
  }

  void _init() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    _groupBox = Hive.openBox<Group>('groups_box');
    _loadGroup();
    _initTasks();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.taskForm, arguments: groupKey);
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
