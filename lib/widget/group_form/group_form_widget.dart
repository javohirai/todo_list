import 'package:flutter/material.dart';
import 'package:todo_list/widget/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({super.key});

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final _model = GroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupFromWidgetProvider(
      model: _model,
      child: const _GroupFormWidgetBody(),
    );
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New group')),
      body: Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const _GroupFormNameWidget()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            GroupFromWidgetProvider.read(context)?.model.saveGroup(),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _GroupFormNameWidget extends StatelessWidget {
  const _GroupFormNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      onSubmitted: (value) =>
          GroupFromWidgetProvider.read(context)?.model.saveGroup(),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Group name',
      ),
    );
  }
}
