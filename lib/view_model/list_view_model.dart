import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo20220809/repository/to_do_repository.dart';
import 'package:todo20220809/state/to_do_state.dart';

import '../model/to_do.dart';

class ListViewModel{
  late WidgetRef ref;

  void setRef(WidgetRef ref){
    this.ref = ref;
  }

  Future<bool> updateTodo(ToDo todo) async {

    //更新用のTODOインスタンス作成
    ToDo todoU = todo.copyWith(isDone: todo.isDone == 0 ? 1 : 0);


    //追加処理
    await ToDoRepository.updateDate(todoU);
    return true;
  }

  Future<bool> deleteTodo(ToDo todo) async {

    //TODOの削除
    await ToDoRepository.deleteDate(todo);
    ref.refresh(todoListProvider);
    return true;
  }
}