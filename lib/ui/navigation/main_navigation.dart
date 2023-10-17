import 'package:flutter/material.dart';
import 'package:todo_list/ui/widget/group_form/group_form_widget.dart';
import 'package:todo_list/ui/widget/groups/groups_widget.dart';
import 'package:todo_list/ui/widget/task_form/task_form_widget.dart';
import 'package:todo_list/ui/widget/tasks/tasks_widget.dart';

abstract class MainNavigationRouteNames {
  static const groups = 'groups';
  static const groupForm = 'groups/form';
  static const tasks = 'groups/tasks';
  static const taskForm = 'groups/tasks/form';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.groups;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.groups: (context) => const GroupsWidget(),
    MainNavigationRouteNames.groupForm: (context) => const GroupFormWidget(),
  };

  Route<Object>? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case MainNavigationRouteNames.tasks:
        final configuration = setting.arguments as TaskWidgetConfiguration;
        return MaterialPageRoute(
            builder: (context) => TasksWidget(configuration: configuration));
      case MainNavigationRouteNames.taskForm:
        final groupKey = setting.arguments as int;
        return MaterialPageRoute(
            builder: (context) => TaskFormWidget(groupKey: groupKey));

      default:
        const widget = Text('Navigation error!!');
        return MaterialPageRoute(
          builder: (context) => widget,
        );
    }
  }
}
