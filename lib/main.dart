import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo20220809/repository/to_do_repository.dart';
import 'package:todo20220809/view/to_do_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ToDoRepository.setDb();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToDoListView(),
    );
  }
}
