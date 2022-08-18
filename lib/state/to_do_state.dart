//一覧のTODO
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo20220809/model/to_do.dart';
import 'package:todo20220809/repository/to_do_repository.dart';

//DBから取得
final todoListProvider = FutureProvider<List<ToDo>>((ref){
  return ToDoRepository.getToDoList();
});

//追加時のテキストコントローラー
final textController = StateProvider((ref) => TextEditingController());
