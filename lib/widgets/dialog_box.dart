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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: SizedBox(
        height: 370,
        width: 400,
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
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  helperText: "Task title",
                  helperStyle: TextStyle(color: Colors.grey),
                  errorStyle: TextStyle(color: Colors.red),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                cursorColor: Colors.black,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: "(optional)",
                  hintStyle: TextStyle(color: Colors.grey),
                  helperText: "Description",
                  helperStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.black, width: 2),
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
                    borderRadius: BorderRadius.zero,
                    border: Border.all(width: 2),
                  ),
                  child: Text(
                    selectedDueDate != null
                        ? DateFormat('MMM d, yyyy').format(selectedDueDate!)
                        : 'Select Due Date',
                  ),
                ),
              ),
              const SizedBox(height: 65),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(),
                    child: ElevatedButton(
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
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        buttonText,
                      ),
                    ),
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
