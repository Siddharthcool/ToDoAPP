import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/utilities/dialog_box.dart';
import 'package:to_do_app/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference this box
  final mybox = Hive.box('mybox');

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app,
    //then create default data

    if (mybox.get("TODOLIST") == null) {
      db.createInitialData();
      db.updateDataBase();
    } else {
      print("data already exists");
    }

    super.initState();
  }

  // // list of todo tasks
  // List<List<dynamic>> toDoList = [
  //   ["make tutorial", false],
  //   ["do exercise", false],
  // ];

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !(db.toDoList[index][1]);
    });
    db.updateDataBase();
  }

  //text editing controller
  final _controller = TextEditingController();

  //save new task
  void saveNewtask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //crete new task
  void CreateNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _controller,
              onCancel: () {
                Navigator.of(context).pop();
              },
              onSave: saveNewtask);
        });
  }

  //delete the task
  void deleteTask(index) {
    setState(() {
      db.toDoList.remove(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 213, 79, 1),
        elevation: 0,
        title: Center(
          child: Text(
            " TO DO  ",

            style: GoogleFonts.playfairDisplay(
              fontSize: 30,
              
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          onPressed: CreateNewTask,
          backgroundColor: Colors.amber,
          shape: CircleBorder(side: BorderSide.none),
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0], // Corrected line
            onChanged: (p0) => checkBoxChanged(p0, index), // Corrected line
            taskCompleted:
                db.toDoList[index][1] as bool, // Added casting to bool
            deleteFunction: (p0) {
              deleteTask(index);
            },
          );
        },
      ),
    );
  }
}
