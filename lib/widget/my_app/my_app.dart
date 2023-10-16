import 'package:flutter/material.dart';
import 'package:todo_list/widget/groups/groups_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      routes: {
        '/groups': (context) => const GroupsWidget(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/groups',
    );
  }
}
