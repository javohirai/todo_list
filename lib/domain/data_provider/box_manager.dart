import 'package:hive/hive.dart';
import 'package:todo_list/domain/entity/group.dart';
import 'package:todo_list/domain/entity/task.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();

  BoxManager._();

  Future<Box<Task>> openTaskBox(int groupKey) async {
    return _openBox(makeTaskBoxName(groupKey), 2, TaskAdapter());
  }

  String makeTaskBoxName(int groupKey) => 'tasks_box_$groupKey';

  Future<Box<Group>> openGroupBox() async {
    return _openBox('groups_box', 1, GroupAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    await box.compact();
    await box.close();
  }

  Future<Box<T>> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}
