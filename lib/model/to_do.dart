import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'to_do.freezed.dart';
part 'to_do.g.dart';

@freezed
class ToDo with _$ToDo {
  const factory ToDo({
    required int id,
    required String title,
    //isDone=0の場合は未完了、1の場合は完了
    required int isDone,
    required DateTime createdTime,
  }) = _ToDo;

  factory ToDo.fromJson(Map<String, dynamic> json) =>
      _$ToDoFromJson(json);
}