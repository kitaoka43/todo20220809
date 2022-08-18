import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo20220809/repository/to_do_repository.dart';
import 'package:todo20220809/view_model/add_view_model.dart';
import 'package:todo20220809/view_model/list_view_model.dart';

import '../model/to_do.dart';
import '../state/to_do_state.dart';

class ToDoListView extends ConsumerWidget {
  const ToDoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(textController);
    final todoState = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ToDoリスト')),
      body: todoState.when(
          data: (data) {
            return SlidableAutoCloseBehavior(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = data[index];
                  return _todoItem(todo, index, ref);
                },
              ),
            );
          },
          error: (error, _) => Text(error.toString()),
          loading: () => const CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('ToDo追加'),
                  content: TextField(
                    controller: controller,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final vm = AddViewModel();
                        vm.setRef(ref);
                        bool result = await vm.addTodo(controller.text);
                        if (result) {
                          ref.refresh(todoListProvider);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('追加する'),
                    ),
                  ],
                ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _todoItem(ToDo todo, int index, WidgetRef ref) {
    final vm = ListViewModel();
    vm.setRef(ref);
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (value) async {
                  await vm.deleteTodo(todo);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: '削除',
              ),
            ],
          ),
          child: CheckboxListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                  decoration: todo.isDone == 1
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            value: todo.isDone == 1 ? true : false,
            onChanged: (value) async {
              bool result = await vm.updateTodo(todo);
              if(result){
                ref.refresh(todoListProvider);
              }
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
      ],
    );
  }
}
