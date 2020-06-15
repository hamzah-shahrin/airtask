import 'package:airtask/models/task.dart';
import 'package:airtask/models/task_group.dart';
import 'package:airtask/services/service_locator.dart';
import 'package:airtask/services/storage_api.dart';
import 'package:flutter/material.dart';

class StorageController extends ChangeNotifier {
  Future<List<Task>> get tasks async =>
      serviceLocator<StorageApi>().fetchTasks();

  Future<List<TaskGroup>> get taskGroups async =>
      serviceLocator<StorageApi>().fetchGroups();

  Future<void> addTask({@required int groupId, @required String text}) async {
    var _tasks = await tasks;
    _tasks.add(Task(
      id: newId(_tasks),
      groupId: groupId,
      text: text,
      completed: false
    ));
    serviceLocator<StorageApi>().saveData(_tasks, await taskGroups);
  }

  Future<void> addGroup({@required String title, @required Color color}) async {
    var _taskGroups = await taskGroups;
    _taskGroups.add(TaskGroup(
      id: newId(_taskGroups),
      title: title,
      color: color
    ));
    serviceLocator<StorageApi>().saveData(await tasks, _taskGroups);
  }

  int newId(List group) {
    try {
      var ids = group.map((e) => e.id).toList();
      ids.sort();
      return ids.last + 1;
    } catch(e) {return 0;}
  }
}