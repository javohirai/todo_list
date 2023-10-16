import 'package:flutter/material.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: const SafeArea(child: _GroupList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _GroupList extends StatefulWidget {
  const _GroupList();
  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<_GroupList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 100,
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
    return const ListTile(
      title: Text('Lorem ispum'),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
