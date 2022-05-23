import 'dart:convert';

import 'package:hive/hive.dart';

class TodoItem {
  final String name;
  final String description;
  final String category;
  final String finishBy;
  TodoItem({
    required this.name,
    required this.description,
    required this.category,
    required this.finishBy,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'category': category});
    result.addAll({'finishBy': finishBy});

    return result;
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      finishBy: map['finishBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory TodoItem.fromJson(String source) =>
      TodoItem.fromMap(json.decode(source));
}
