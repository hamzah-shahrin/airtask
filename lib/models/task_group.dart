import 'package:flutter/cupertino.dart';

class TaskGroup {
  int id;
  String title;
  Color color;

  TaskGroup({@required this.id, @required this.title, @required this.color});

  TaskGroup.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      color = Color(json['color']);

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'color': color.value
      };
}