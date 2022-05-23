import 'dart:convert';

import 'package:todo/domain/entities/todo_model.dart';

class TodoItemList {
  //Variabls
  List<TodoItem> list;

  //Constructor
  TodoItemList({
    required this.list,
  });

  //Convert to Map
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'todoItemList': list.map((x) => x.toMap()).toList()});
    return result;
  }

  //Get Object from Map
  factory TodoItemList.fromMap(Map<String, dynamic> map) {
    return TodoItemList(
      list: List<TodoItem>.from(map['todoItemList']?.map((x) => TodoItem.fromMap(x))),
    );
  }

  //Convert object to string of map
  String toJson() => json.encode(toMap());

  //Convert string to object
  factory TodoItemList.fromJson(String source) => TodoItemList.fromMap(json.decode(source));
}
