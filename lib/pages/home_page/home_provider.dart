import 'package:flutter/material.dart';
import 'package:untitled/pages/home_page/home_widgets/todo_tile_list.dart';

class HomeProv with ChangeNotifier {
  bool _showAll = false;
  bool get showAll => _showAll;

  set reShow(bool value) {
    _showAll = value;

    notifyListeners();
  }

  bool _showError = true;
  bool get showError => _showError;

  void showEr() {
    _showError = false;

    notifyListeners();
  }

  bool _isCollapsed = true;

  bool get isCollapsed => _isCollapsed;

  void setIsCollapsed(bool value) {
    _isCollapsed = value;
    notifyListeners();
  }

  late void Function(TaskTile task) _onTaskTap;

  void onTaskTap(TaskTile task) {
    _onTaskTap(task);
  }

  void setOnTaskTap(void Function(TaskTile task) value) {
    _onTaskTap = value;
  }

  late void Function() _onNewTaskTap;

  void Function() get onNewTaskTap => _onNewTaskTap;

  void setOnNewTaskTap(void Function() value) {
    _onNewTaskTap = value;
  }
}
