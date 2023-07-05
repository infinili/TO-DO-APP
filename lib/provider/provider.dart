import 'package:flutter/material.dart';
import 'package:untitled/model/model.dart';
import 'package:untitled/data/task.dart';
import 'package:untitled/logger/logger.dart';

class Data with ChangeNotifier {
  Model? _model = null;

  List<Task> get getTasks => _model!.tasks;
  int get getCount => _model!.count;
  int get completedCnt => _model!.completedCnt;
  bool get showAll => _model!.showAll;

  void reShow(bool value) {
    MyLogger.instance.mes('Changed showing');
    _model!.showAll = value;

    notifyListeners();
  }

  Future<bool> init() async {
    if (_model == null) {
      _model = Model();
      await _model!.init();
      return true;
    } else
      return true;
  }

  void deleteTask(int id) {
    _model!.deleteTask(id);
    _model!.saveToLocal();
    MyLogger.instance.mes('Deleted task');

    notifyListeners();
  }

  void addTask(String title, bool completed, String priority, DateTime? date) {
    _model!.addTask(title, completed, priority, date);
    _model!.saveToLocal();
    MyLogger.instance.mes('Added task');

    notifyListeners();
  }

  void changeTask(Task task, String title, String priority, DateTime? date) {
    _model!.changeTask(task, title, priority, date);
    _model!.saveToLocal();
    MyLogger.instance.mes('Changed task');

    notifyListeners();
  }

  void changeActive(int ind, bool isAdd) {
    _model!.setComp(ind);
    (isAdd) ? _model!.addCompleted() : _model!.delCompleted();
    MyLogger.instance.mes('Changed if the task was marked completed or not');
    _model!.saveToLocal();

    notifyListeners();
  }

  void deleteAll() {
    _model!.deleteAll();
  }
}
