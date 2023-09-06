import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogBox extends StatefulWidget {
  final Function(String, String, DateTime?) onAddTask;
  final String changeTask;
  final String changedescription;
  final bool isEditing;

  const DialogBox({
    Key? key,
    required this.onAddTask,
    required this.changeTask,
    required this.changedescription,
    required this.isEditing,
  }) : super(key: key);

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime? selectedDueDate;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();

    _taskController.text = widget.changeTask;
    _descriptionController.text = widget.changedescription;
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.isEditing;
    final buttonText = isEditing ? 'Save' : 'Add';

    return AlertDialog(
      backgroundColor: Colors.deepPurple.shade100,
      content: SizedBox(
        height: 320,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
                focusNode: _focusNode,
                controller: _taskController,
                decoration: InputDecoration(
                  helperText: "Task title",
                  focusColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "(optional)",
                  helperText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: selectedDueDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  ).then((pickedDate) {
                    if (pickedDate != null) {
                      setState(() {
                        selectedDueDate = pickedDate;
                      });
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Text(
                    selectedDueDate != null
                        ? DateFormat('MMM d, yyyy').format(selectedDueDate!)
                        : 'Select Due Date',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: Colors.grey,
                    // ),
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String newTask = _taskController.text;
                        String newDescription = _descriptionController.text;
                        widget.onAddTask(
                            newTask, newDescription, selectedDueDate);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text(buttonText),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
