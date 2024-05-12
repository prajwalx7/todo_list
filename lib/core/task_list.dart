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
  //task priority dot
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
    return Colors.grey; //default color
  }

  //slideable delete button
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              spacing: 8,
              borderRadius: BorderRadius.zero,
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
              isEditing = true; // Set isEditing to true when editing starts
            });
            widget.onLongPress?.call();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            decoration: const BoxDecoration(
              color: Colors.white, // color of task bg
              borderRadius: BorderRadius.zero,

              boxShadow: [
                BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 1,
                  blurStyle: BlurStyle.normal,
                  color: Colors.black,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // checkbox
                    Checkbox(
                      value: widget.isDone,
                      onChanged: widget.onChanged,
                      activeColor: Colors.white,
                    ),

                    //task heading
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

                    // task date
                    if (widget.dueDate != null)
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.zero,
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

                  //task description
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
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
