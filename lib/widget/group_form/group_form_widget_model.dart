import 'package:flutter/material.dart';

class GroupFormWidgetModel {
  void saveGroup() {
    print('hey hey');
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
