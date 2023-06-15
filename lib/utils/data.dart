import 'package:flutter/material.dart';

class Data with ChangeNotifier {
  List<List> toDoList = [
    [
      'Купить что-то где-то зачем-то, не понятно зачем, но надо больше текста, поэтому еще допишем и еще немного',
      false,
      1
    ],
    ['Что-то сделать еще', false, 1],
    ['Что-то сделать еще', false, 2],
    ['Что-то сделать', true, 0],
  ];
  List<List> DoneList = [];
  List<List> UnDoneList = [];

  bool showAll = false;
  int? priority = 0;
  bool taskTouched = false;

  void reShow() {
    if (!showAll) {
      showAll = true;
    } else {
      showAll = false;
    }

    notifyListeners();
  }

  //remaking already made task
  void remake(int index, String title, bool completed, int? priority) {
    toDoList[index] = [title, completed, priority];

    notifyListeners();
  }

  void touch(bool value) {
    taskTouched = value;

    notifyListeners();
  }

  //list of done tasks
  void getDoneList() {
    DoneList.clear();
    for (List<dynamic> sublist in toDoList) {
      if (sublist[1] == true) {
        DoneList.add(sublist);
      }
    }

    notifyListeners();
  }

  //list of undone tasks
  void getUnDoneList() {
    UnDoneList.clear();
    List<List<dynamic>> list = [];
    list.addAll(toDoList);
    list.removeWhere((element) {
      return element[1] == true;
    });
    UnDoneList.addAll(list);

    notifyListeners();
  }

  //delete task from toDoList
  void deleteTask(int index) {
    toDoList.removeAt(index);

    notifyListeners();
  }

  //delete task from UnDoneList
  void deleteUnDoneTask(int index) {
    UnDoneList.removeAt(index);

    notifyListeners();
  }

  void createNewTask(String title, bool completed, int? prioruty) {
    toDoList.add([title, completed, priority]);

    notifyListeners();
  }

  void makeTaskCompleted(int index, bool? completed) {
    if (toDoList[index][1] = !completed!) {
      toDoList[index][1] = completed;
    }

    notifyListeners();
  }

  //set priority
  void setPriority(int? value) {
    priority = value;

    notifyListeners();
  }
}
