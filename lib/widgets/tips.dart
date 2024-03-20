import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  const Tips({super.key});

  final Color customGreen = const Color(0xff03C988);
  final Color customRed = const Color(0xffF45050);
  final Color customYellow = const Color(0xff03C988);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const Text(
        'Instructions',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('How to add a task:'),
            const Text('- Press the "+" icon.'),
            const Text('- Enter the task title and tap "Add".'),
            const SizedBox(height: 16),
            const Text('How to delete a task:'),
            const Text('- Swipe left on the task and tap "Delete".'),
            const SizedBox(height: 16),
            const Text('How to edit a task:'),
            const Text('- Long press on the task to edit it.'),
            const Text('- Make your changes and tap "Save".'),
            const SizedBox(height: 16),
            const Text('Indications: '),
            Row(
              children: [
                Icon(Icons.circle, color: customGreen),
                const Text(' Task Completion.'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.circle, color: customRed),
                const Text(' Task with High Priority.'),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.circle, color: Colors.yellow),
                Text(' Task with Low Priority.'),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.circle, color: Colors.grey),
                Text(' Task with No Priority.'),
              ],
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
