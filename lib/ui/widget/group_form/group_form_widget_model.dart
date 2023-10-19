import 'package:flutter/material.dart';
import 'package:todo_list/domain/data_provider/box_manager.dart';
import 'package:todo_list/domain/entity/group.dart';

class GroupFormWidgetModel extends ChangeNotifier {
  var _groupName = '';
  String? errorText;

  set groupName(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _groupName = value;
  }

  void saveGroup(BuildContext context) async {
    final groupName = _groupName.trim();
    if (groupName.isEmpty) {
      errorText = 'Enter valid group name';
      notifyListeners();
      return;
    }
    final box = await BoxManager.instance.openGroupBox();
    final group = Group(name: groupName);
    await box.add(group);
    Navigator.of(context).pop();
  }
}

class GroupFromWidgetProvider extends InheritedNotifier {
  final GroupFormWidgetModel model;
  const GroupFromWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );
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
    return false;
  }
}
