import 'package:flutter/material.dart';
import 'package:todo_list/widget/group_form/group_form_widget.dart';
import 'package:todo_list/widget/groups/groups_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      routes: {
        '/groups': (context) => const GroupsWidget(),
        '/groups/from': (context) => const GroupFormWidget(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/groups',
    );
  }
}
