import 'package:flutter/cupertino.dart';

class Task {
  int id;
  int groupId;
  String text;
  bool completed;

  Task({@required this.id, @required this.groupId, @required this.text,
    @required this.completed});

  Task.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      groupId = json['groupId'],
      text = json['text'],
      completed = json['completed'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'groupId': groupId,
        'text': text,
        'completed': completed
      };

}