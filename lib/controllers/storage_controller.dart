import 'package:airtask/models/task.dart';
import 'package:airtask/models/task_group.dart';
import 'package:airtask/services/service_locator.dart';
import 'package:airtask/services/storage_api.dart';
import 'package:flutter/material.dart';

class StorageController extends ChangeNotifier {

  Future<List<Task>> _tasks;
  Future<List<TaskGroup>> _taskGroups;

  Future<List<Task>> get tasks async => _tasks;
  Future<List<TaskGroup>> get taskGroups async => _taskGroups;

  Future<void> initController() async {
    _tasks = serviceLocator<StorageApi>().fetchTasks();
    _taskGroups = serviceLocator<StorageApi>().fetchGroups();
    notifyListeners();
  }

  Future<void> addTask({@required int groupId, @required String text}) async {
    var _tasks = await tasks;
    _tasks.add(Task(
      id: newId(_tasks),
      groupId: groupId,
      text: text,
      completed: false
    ));
    serviceLocator<StorageApi>().saveData(_tasks, await taskGroups);
    notifyListeners();
  }

  Future<void> editTask({@required int id, @required groupId, String text, bool completed}) async {
    var _tasks = await tasks;
    _tasks[_tasks.indexWhere((e) => e.id==id)] = Task(
        id: id, text: text, completed: completed, groupId: groupId);
    serviceLocator<StorageApi>().saveData(_tasks, await taskGroups);
    notifyListeners();
  }

  Future<void> deleteTask({@required int id}) async {
    var _tasks = await tasks;
    _tasks.removeWhere((element) => element.id == id);
    serviceLocator<StorageApi>().saveData(_tasks, await taskGroups);
    notifyListeners();
  }

  Future<void> addGroup({@required String title, @required Color color}) async {
    var _taskGroups = await taskGroups;
    _taskGroups.add(TaskGroup(
      id: newId(_taskGroups), title: title, color: color));
    serviceLocator<StorageApi>().saveData(await tasks, _taskGroups);
    notifyListeners();
  }

  Future<void> editGroup({@required int id, String title, Color color}) async {
    var _taskGroups = await taskGroups;
    _taskGroups[_taskGroups.indexWhere((e) => e.id==id)] = TaskGroup(
      id: id, title: title, color: color);
    serviceLocator<StorageApi>().saveData(await tasks, _taskGroups);
    notifyListeners();
  }

  Future<void> deleteGroup({@required int id}) async {
    var _taskGroups = await taskGroups;
    var _tasks = await tasks;
    _taskGroups.removeWhere((element) => element.id == id);
    _tasks.removeWhere((element) => element.groupId == id);
    serviceLocator<StorageApi>().saveData(await tasks, _taskGroups);
    notifyListeners();
  }

  Future<TaskGroup> getGroup({@required int id}) async {
    return (await taskGroups).firstWhere((element) => element.id == id);
  }

  int newId(List group) {
    try {
      var ids = group.map((e) => e.id).toList();
      ids.sort();
      return ids.last + 1;
    } catch(e) {return 0;}
  }
}