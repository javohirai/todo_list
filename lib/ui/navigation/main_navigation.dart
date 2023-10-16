import 'package:flutter/material.dart';
import 'package:todo_list/ui/widget/group_form/group_form_widget.dart';
import 'package:todo_list/ui/widget/groups/groups_widget.dart';
import 'package:todo_list/ui/widget/task_form/task_form_widget.dart';
import 'package:todo_list/ui/widget/tasks/tasks_widget.dart';

abstract class MainNavigationRouteNames {
  static String groups = '/groups';
  static String groupForm = '/groups/form';
  static String tasks = '/groups/tasks';
  static String taskForm = '/groups/tasks/form';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.groups: (context) => const GroupsWidget(),
    MainNavigationRouteNames.groupForm: (context) => const GroupFormWidget(),
    MainNavigationRouteNames.tasks: (context) => const TasksWidget(),
    MainNavigationRouteNames.taskForm: (context) => const TaskFormWidget(),
  };
}
