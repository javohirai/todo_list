import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/domain/entity/group.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late Future<Box<Group>> _groupBox;
  Group? _group;
  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}) {
    _init();
  }

  void _loadGroup() async {
    var box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _init() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('groups_box');
    _loadGroup();
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
