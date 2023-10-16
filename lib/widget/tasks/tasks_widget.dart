import 'package:flutter/material.dart';
import 'package:todo_list/widget/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  TasksWidgetState createState() => TasksWidgetState();
}

class TasksWidgetState extends State<TasksWidget> {
  TasksWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      int groupKey = ModalRoute.of(context)?.settings.arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if (model != null) {
      return TasksWidgetModelProvider(
        model: model,
        child: const _TasksWidgetBody(),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class _TasksWidgetBody extends StatelessWidget {
  const _TasksWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.watch(context)?.model;
    final title = model?.group?.name ?? 'Tasks';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
