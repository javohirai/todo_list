import 'package:flutter/material.dart';
import 'package:todo_list/ui/widget/task_form/task_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  final groupKey;
  const TaskFormWidget({
    super.key,
    required this.groupKey,
  });

  @override
  TaskFormWidgetState createState() => TaskFormWidgetState();
}

class TaskFormWidgetState extends State<TaskFormWidget> {
  late final TaskFormWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskFormWidgetModel(groupKey: widget.groupKey);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (_model == null) {
  //     final groupKey = ModalRoute.of(context)?.settings.arguments as int;
  //     _model = TaskFormWidgetModel(groupKey: groupKey);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetModelProvider(
      model: _model!,
      child: const _TaskFormWidgetBody(),
    );
  }
}

class _TaskFormWidgetBody extends StatelessWidget {
  const _TaskFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New task')),
      body: Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const _TaskFormNameWidget()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            TaskFormWidgetModelProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _TaskFormNameWidget extends StatelessWidget {
  const _TaskFormNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      expands: true,
      minLines: null,
      maxLines: null,
      onChanged: (value) => {model?.taskName = value},
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Task name',
      ),
    );
  }
}
