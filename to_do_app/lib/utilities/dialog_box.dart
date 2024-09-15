import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller; // Specify the type
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 160, // Adjusted the height for better spacing
        width: 200, // Adjusted the width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Get user input
            Row(
              children: [
                const Icon(Icons.notes),
                const SizedBox(
                    width: 10), // Add spacing between icon and text field
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Add a new Task",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Add spacing between input and buttons

            // Buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cancel button
                MyButton(
                  onPressed: () {
                    onCancel; // Close the dialog on cancel
                  },
                  text: "Cancel",
                ),
                const SizedBox(width: 10),
                // Save button
                MyButton(
                  onPressed: onSave,
                  text: "Save",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
