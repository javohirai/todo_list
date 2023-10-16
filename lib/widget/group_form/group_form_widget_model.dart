import 'package:flutter/material.dart';

class GroupFormWidgetModel {
  var groupName = '';
  void saveGroup(BuildContext context) {
    print(groupName);
  }
}

class GroupFromWidgetProvider extends InheritedWidget {
  final GroupFormWidgetModel model;
  const GroupFromWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);
  static GroupFromWidgetProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFromWidgetProvider>();
  }

  static GroupFromWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFromWidgetProvider>()
        ?.widget;
    return widget is GroupFromWidgetProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant GroupFromWidgetProvider oldWidget) {
    return true;
  }
}
