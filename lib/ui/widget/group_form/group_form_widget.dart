import 'package:flutter/material.dart';
import 'package:todo_list/ui/widget/group_form/group_form_widget_model.dart';

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
  const _GroupFormWidgetBody();

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
            GroupFromWidgetProvider.read(context)?.model.saveGroup(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class _GroupFormNameWidget extends StatelessWidget {
  const _GroupFormNameWidget();

  @override
  Widget build(BuildContext context) {
    final model = GroupFromWidgetProvider.watch(context)?.model;
    return TextField(
      autofocus: true,
      onChanged: (value) => {model?.groupName = value},
      onSubmitted: (value) =>
          model?.saveGroup(context),
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        errorText: model?.errorText,
        hintText: 'Group name',
      ),
    );
  }
}
