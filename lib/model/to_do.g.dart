// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToDo _$$_ToDoFromJson(Map<String, dynamic> json) => _$_ToDo(
      id: json['id'] as int,
      title: json['title'] as String,
      isDone: json['isDone'] as int,
      createdTime: DateTime.parse(json['createdTime'] as String),
    );

Map<String, dynamic> _$$_ToDoToJson(_$_ToDo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isDone': instance.isDone,
      'createdTime': instance.createdTime.toIso8601String(),
    };
