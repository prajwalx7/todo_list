import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TaskList extends StatefulWidget {
  final int index;
  final String task;
  final String description;
  final bool isDone;
  final Function(bool?)? onChanged;
  final void Function(int) removeTask;
  final VoidCallback? onLongPress;
  final DateTime? dueDate;

  const TaskList({
    Key? key,
    required this.index,
    required this.task,
    required this.description,
    required this.isDone,
    required this.onChanged,
    required this.removeTask,
    required this.onLongPress,
    required this.dueDate,
  }) : super(key: key);

  @override
  TaskListState createState() => TaskListState();
}

class TaskListState extends State<TaskList> {
  bool isEditing = false;

  Color getBorderColor(DateTime? dueDate, bool isDone) {
    if (isDone) {
      return const Color(0xff03C988);
    } else if (dueDate != null) {
      final now = DateTime.now();
      final daysUntilDue = dueDate.difference(now).inDays;

      if (daysUntilDue <= 1) {
        return const Color(0xffF45050);
      } else if (daysUntilDue <= 3) {
        return Colors.yellow;
      }
    }
    return Colors.grey; // Default color
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              spacing: 8,
              borderRadius: BorderRadius.circular(18),
              onPressed: (BuildContext context) =>
                  widget.removeTask(widget.index),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: GestureDetector(
          onLongPress: () {
            setState(() {
              isEditing = true; // Set isEditing to true when editing starts.
            });
            widget.onLongPress?.call();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white, // color of task bg
              borderRadius: BorderRadius.circular(18),
              // border: Border.all(
              //   width: 3,
              //   color: getBorderColor(
              //       widget.dueDate, widget.isDone), // dynamic container color
              // ),
              boxShadow: const [
                BoxShadow(blurRadius: 5, color: Colors.black12, spreadRadius: 2)
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: widget.isDone,
                      onChanged: widget.onChanged,
                      activeColor: Colors.black,
                    ),
                    Expanded(
                      child: Text(
                        widget.task,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: widget.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    if (widget.dueDate != null)
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          DateFormat('MMM d, yyyy').format(widget.dueDate!),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: getBorderColor(widget.dueDate, widget.isDone)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.description.isNotEmpty)
                  Flexible(
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}