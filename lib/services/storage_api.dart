import 'dart:convert';

import 'package:airtask/models/task.dart';
import 'package:airtask/models/task_group.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageApi {
  Future<List<Task>> fetchTasks();
  Future<List<TaskGroup>> fetchGroups();
  
  Future<void> saveData(List<Task> tasks, List<TaskGroup> taskGroups);
}

class StorageApiImpl implements StorageApi {
  @override
  Future<List<TaskGroup>> fetchGroups() async {
    final prefs = await SharedPreferences.getInstance();
    List<TaskGroup> taskGroups = [];
    if (prefs.containsKey('taskGroups') && prefs.get('taskGroups').length > 0)
      jsonDecode(prefs.get('taskGroups')).forEach((key, value){
        taskGroups.add(TaskGroup.fromJson(jsonDecode(value)));
      });
    return taskGroups;
  }

  @override
  Future<List<Task>> fetchTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<Task> tasks = [];
    if (prefs.containsKey('tasks') && prefs.get('tasks').length > 0)
      jsonDecode(prefs.get('tasks')).forEach((key, value){
        tasks.add(Task.fromJson(jsonDecode(value)));
      });
    return tasks;
  }

  @override
  Future<void> saveData(List<Task> tasks, List<TaskGroup> taskGroups) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString('tasks', jsonEncode(tasks.asMap().map((key, value)
      => MapEntry(key.toString(), jsonEncode(value.toJson())))));
    prefs.setString('taskGroups', jsonEncode(taskGroups.asMap().map((key, value)
      => MapEntry(key.toString(), jsonEncode(value.toJson())))));
  }
}

class FakeStorageApiImpl implements StorageApi {
  @override
  Future<List<TaskGroup>> fetchGroups() async {
    var taskGroups = <TaskGroup>[];
    taskGroups.add(TaskGroup(
      id: 0,
      title: 'Test Zero',
      color: Colors.accents[0],
    ));
    taskGroups.add(TaskGroup(
      id: 1,
      title: 'Test One',
      color: Colors.accents[1],
    ));
    taskGroups.add(TaskGroup(
      id: 2,
      title: 'Test Two',
      color: Colors.accents[2],
    ));
    return taskGroups;
  }

  @override
  Future<List<Task>> fetchTasks() async {
    var tasks = <Task>[];
    tasks.add(Task(
      id: 0,
      groupId: 0,
      text: "Test task 0",
      completed: true,
    ));
    tasks.add(Task(
      id: 1,
      groupId: 1,
      text: "Test task 1",
      completed: false,
    ));
    tasks.add(Task(
      id: 2,
      groupId: 1,
      text: "Test task 2",
      completed: false,
    ));
    return tasks;
  }

  @override
  Future<void> saveData(List<Task> tasks, List<TaskGroup> taskGroups) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

}