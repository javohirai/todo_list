import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      body: const _TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList();
  @override
  Widget build(BuildContext context) {
    final taskCount =
        TasksWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemCount: taskCount,
      itemBuilder: (context, index) {
        return _GroupListRowWidget(indexInList: index);
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 1);
      },
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({
    super.key,
    required this.indexInList,
  });

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.read(context)?.model;
    final task = model?.tasks[indexInList];
    final currentState = task?.isDone ?? false;

    final icon = currentState ? Icons.done : Icons.portrait;
    final style =
        currentState ? TextStyle(decoration: TextDecoration.lineThrough) : null;

    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => model?.deleteTask(indexInList),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          task?.text ?? '',
          style: style,
        ),
        trailing: Icon(icon),
        onTap: () => model?.doneToggle(indexInList),
      ),
    );
  }
}
