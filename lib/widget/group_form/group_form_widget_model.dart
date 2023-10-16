import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/domain/entity/group.dart';

class GroupFormWidgetModel {
  var groupName = '';
  void saveGroup(BuildContext context) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (groupName.isEmpty) return;
    final box = await Hive.openBox<Group>('groups_box');
    final group = Group(name: groupName);
    await box.add(group);
    Navigator.of(context).pop();
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
