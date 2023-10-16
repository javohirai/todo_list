import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/ui/widget/groups/groups_widget_model.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({super.key});

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(
      model: _model,
      child: const _GroupsWidgetBody(),
    );
  }
}

class _GroupsWidgetBody extends StatelessWidget {
  const _GroupsWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: const SafeArea(child: _GroupList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GroupsWidgetModelProvider.read(context)
            ?.model
            .showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupList extends StatelessWidget {
  const _GroupList();
  @override
  Widget build(BuildContext context) {
    final groupCount = GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemCount: groupCount,
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
    final model = GroupsWidgetModelProvider.read(context)?.model;
    final group = model?.groups[indexInList];
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => model?.deleteGroup(indexInList),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text('${group?.name}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => model?.showTasks(context, indexInList),
      ),
    );
  }
}
