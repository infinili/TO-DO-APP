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

  // List<List> toDoList = [
  //   [
  //     'Купить что-то где-то зачем-то, не понятно зачем, но надо больше текста, поэтому еще допишем и еще немного',
  //     false,
  //     1
  //   ],
  //   ['Что-то сделать еще', false, 1],
  //   ['Что-то сделать еще', false, 2],
  //   ['Что-то сделать', true, 0],
  // ];
  // List<List> doneList = [];
  // List<List> unDoneList = [];

  // bool showAll = false;
  // bool taskTouched = false;

  // void reShow() {
  //   MyLogger.instance.mes('Change showing');
  //   if (!showAll) {
  //     showAll = true;
  //   } else {
  //     showAll = false;
  //   }

  //   notifyListeners();
  // }

  // //remaking already made task
  // void remake(
  //     int index, String title, bool completed, int? priority, String date) {
  //   MyLogger.instance.mes('Remade $index task');
  //   if (showAll) {
  //     toDoList[index] = [title, completed, priority, date];
  //   } else {
  //     unDoneList[index] = [title, completed, priority, date];
  //   }

  //   notifyListeners();
  // }

  // void touch(bool value) {
  //   taskTouched = value;

  //   notifyListeners();
  // }

  // //list of done tasks
  // void getDoneList() {
  //   doneList.clear();
  //   for (List<dynamic> sublist in toDoList) {
  //     if (sublist[1] == true) {
  //       doneList.add(sublist);
  //     }
  //   }

  //   notifyListeners();
  // }

  // //list of undone tasks
  // void getUnDoneList() {
  //   unDoneList.clear();
  //   List<List<dynamic>> list = [];
  //   list.addAll(toDoList);
  //   list.removeWhere((element) {
  //     return element[1] == true;
  //   });
  //   unDoneList.addAll(list);

  //   notifyListeners();
  // }

  // //delete task from toDoList
  // void deleteTask(int index) {
  //   MyLogger.instance.mes('Task $index deleted');
  //   toDoList.removeAt(index);

  //   notifyListeners();
  // }

  // //delete task from unDoneList
  // void deleteUnDoneTask(int index) {
  //   MyLogger.instance.mes('Task $index deleted');
  //   unDoneList.removeAt(index);

  //   notifyListeners();
  // }

  // void createNewTask(String title, bool completed, int? priority, String date) {
  //   MyLogger.instance.mes('Create task $title');
  //   toDoList.add([title, completed, priority, date]);

  //   notifyListeners();
  // }

  // void makeTaskCompleted(int index, bool? completed) {
  //   MyLogger.instance.mes('Checked $index task');
  //   if (toDoList[index][1] = !completed!) {
  //     toDoList[index][1] = completed;
  //   }

  //   notifyListeners();
  // }

  // int? priority = 0;

  // void setPriority(int? value) {
  //   MyLogger.instance.mes('Priority set');
  //   priority = value;

  //   notifyListeners();
  // }

  // bool switcher = false;

  // void changeButton(bool value) {
  //   MyLogger.instance.mes('Date button was switched');
  //   switcher = value;

  //   notifyListeners();
  // }

  // DateTime? selectedDate =
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // DateTime currentDate =
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  // String? selectedDay = DateFormat('dd MMMM yyyy', 'ru').format(DateTime.now());

  // void changeDate(DateTime? date) {
  //   MyLogger.instance.mes('Date was changed');
  //   selectedDate = date;
  //   selectedDay = DateFormat('dd MMMM yyyy', 'ru').format(selectedDate!);

  //   notifyListeners();
  // }
}
