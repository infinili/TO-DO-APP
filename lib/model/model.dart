import 'dart:convert';
import 'dart:math';

import 'package:untitled/data/database.dart';
import 'package:untitled/data/task.dart';

class Model {
  List<Task> _tasks = [];
  late DataBase _localDatabase;
  int _lastId = 0;
  int _count = 0;
  bool _showAll = false;
  int _completedCnt = 0;

  int get count => _count;

  List<Task> get tasks => _tasks;

  int get completedCnt => _completedCnt;

  bool get showAll => _showAll;

  set showAll(bool value) {
    _showAll = value;
  }

  Future<void> init() async {
    _localDatabase = DataBase();
    await _localDatabase.init();
    var jsonTasks = _localDatabase.getFromDB();
    int lastId = 0;
    int cnt = 0;
    int compcCount = 0;
    List<Task> tmp = [];
    if (jsonTasks != null) {
      _tasks = jsonTasks.map((e) => Task.fromJson(json.decode(e))).toList()
          as List<Task>;
      cnt = _tasks.length;
      for (int i = 0; i < _tasks.length; i++) {
        tmp.add(Task.fromJson(json.decode(jsonTasks[i])));
        if (tmp[i].completed) {
          compcCount++;
        }
        lastId = max(lastId, tmp[i].id);
      }
      _completedCnt = compcCount;
      _count = cnt;
      _lastId = lastId + 1;
    }
  }

  void saveToLocal() {
    _localDatabase
        .writeToDB(_tasks.map((e) => jsonEncode(e.toJson())).toList());
  }

  void addTask(String title, bool completed, String priority, DateTime? date) {
    _tasks.add(Task(
        title: title,
        completed: completed,
        priority: priority,
        id: _lastId,
        date: date));
    _lastId += 1;
    _count += 1;
  }

  void addCompleted() {
    _completedCnt += 1;
  }

  void delCompleted() {
    _completedCnt -= 1;
  }

  void deleteTask(int id) {
    _tasks.removeWhere((element) {
      if (element.id == id && element.completed) {
        _completedCnt -= 1;
      }
      return element.id == id;
    });
    _count -= 1;
  }

  void setComp(int id) {
    for (int i = 0; i < _count; i++) {
      if (id == _tasks[i].id) {
        _tasks[i].completed = !_tasks[i].completed;
      }
    }
  }

  void changeTask(Task task, String title, String priority, DateTime? date) {
    for (int i = 0; i < count; i++) {
      if (_tasks[i].id == task.id) {
        _tasks[i].title = title;
        _tasks[i].priority = priority;
        _tasks[i].date = date;
      }
    }
  }

  void deleteAll() {
    _tasks.clear();
  }
}
