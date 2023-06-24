import 'package:shared_preferences/shared_preferences.dart';

class DataBase {
  late SharedPreferences _db;

  DataBase();

  Future<void> init() async {
    _db = await SharedPreferences.getInstance();
  }

  void writeToDB(List<String> tasks) {
    _db.setStringList('tasks', tasks);
  }

  List<String>? getFromDB() {
    return _db.getStringList('tasks');
  }
}




// import 'package:untitled/logger/logger.dart';
// import 'package:untitled/data/task.dart';

// class DataBase {
//   DataBase._();
//   static DataBase instance = DataBase._();
//   factory DataBase() => instance;

//   late Box _box;
//   int get length => _box.length;

//   Future<void> initAsync() async {
//     await Hive.initFlutter();
//     _box = await Hive.openBox('TODO');
//   }

//   void addTask(Task task) {
//     MyLogger.instance.mes('Create Task' '${task.toJson()}');

//     _box.add(task.toJson());
//   }

//   void updateTask(int index, Task task) {
//     MyLogger.instance.mes('Update Task ' '$index ${task.toJson()}');

//     _box.putAt(index, task.toJson());
//   }

//   Task getTaskById(int index) {
//     MyLogger.instance.mes('Get Task by id ' '$index');

//     return Task.fromJson(_box.getAt(index));
//   }

//   void removeTaskByid(int index) {
//     MyLogger.instance.mes('Removed task by id ' '$index');

//     _box.deleteAt(index);
//   }

//   void deleteAll() {
//     _box.clear();
//   }
// }
