import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final double fontSize; // Add customizable font size
  final FontWeight fontWeight; // Add customizable font weight

  TodoTile({
    Key? key,
    required this.taskName,
    required this.onChanged,
    required this.taskCompleted,
    required this.deleteFunction,
    this.fontSize = 18.0, // Default font size
    this.fontWeight = FontWeight.normal, // Default font weight
  }) : super(key: key);

  // creating a methond for capitalizing the
  // first letter of task word shoulf be caps

  String capitalizeFirstLetter(String task) {
    if (task.isEmpty) return task;
    return task[0].toUpperCase() + task.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              label: 'Delete',
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              // Task name with customizable font size and weight
              Text(
                capitalizeFirstLetter(taskName),
                style: GoogleFonts.poppins(
                  fontSize: fontSize, // Set font size
                  fontWeight: fontWeight, // Set font weight
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Colors.black,
                  decorationThickness:2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
