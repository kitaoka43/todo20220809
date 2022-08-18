import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo20220809/repository/to_do_repository.dart';

import '../model/to_do.dart';

class AddViewModel{
  late WidgetRef ref;

  void setRef(WidgetRef ref){
    this.ref = ref;
  }
  
  Future<bool> addTodo(String todoText) async {
    //バリデーションチェック
    if(todoText.isEmpty || todoText.length > 20){
      return false;
    }
    
    //追加用のTODOインスタンス作成
    ToDo todo = ToDo(id: 0, title: todoText, isDone: 0, createdTime: DateTime.now());

    //追加処理
    await ToDoRepository.insertTodo(todo);
    return true;
  }
}