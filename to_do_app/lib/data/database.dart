import 'package:hive_flutter/adapters.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference the box
  final mybox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      ["make tutorial", false],
      ["do exercise", false]
    ];
  }

  //load the data from database

  void loadData() {
    toDoList = mybox.get("TODOLIST");
  }

  //update the database
  void updateDataBase() {
    mybox.put("TODOLIST", toDoList);
  }
}
