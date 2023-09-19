import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list/core/task_data.dart';
import 'package:todo_list/core/task_list.dart';
import 'package:todo_list/widgets/animation.dart';
import 'package:todo_list/widgets/dialog_box.dart';
import 'package:todo_list/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int editingIndex = 1;
  bool isEditing = false;
  List<TaskData> myTasks = [];
  bool taskExist = true;

  late AnimationController _animationController;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

// Check box function
  void checkBoxState(bool value, int index) {
    setState(() {
      myTasks[index] = myTasks[index].copyWith(isDone: value);
    });
  }

  //add task function
  void addTask(String task, String description, DateTime? dueDate) {
    final newTask = TaskData(
      task: task,
      description: description,
      isDone: false,
      dueDate: dueDate,
    );

    setState(() {
      myTasks.add(newTask);
      _listKey.currentState?.insertItem(
        myTasks.length - 1,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  //remove task function
  void removeTask(int index) {
    if (index >= 0 && index < myTasks.length) {
      final removedTask = myTasks.removeAt(index);
      if (myTasks.isEmpty) {
        setState(() {
          taskExist = false;
        });
      }
      _listKey.currentState!.removeItem(
        index,
        (context, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: TaskList(
              index: index,
              task: removedTask.task,
              description: removedTask.description,
              isDone: removedTask.isDone,
              onChanged: (value) => checkBoxState(value!, index),
              removeTask: removeTask,
              onLongPress: () {
                setState(() {
                  isEditing = true;
                  editingIndex = index;
                });
                _editTask(context, index);
              },
              dueDate: removedTask.dueDate,
            ),
          );
        },
        duration: const Duration(milliseconds: 500),
      );
      setState(() {});
    }
  }

  void editTask(int index, String task, String description, DateTime? dueDate) {
    setState(() {
      myTasks[index] = myTasks[index]
          .copyWith(task: task, description: description, dueDate: dueDate);
    });
  }

  // when no task is assigned animation is displayed
  Widget _buildEmptyListWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, right: 25.0),
            child: LottieBuilder.asset(
              "assets/sleepy.json",
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            "You Dont seem busy!",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

// on press it open the dialog box
  void _onAddButtonTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onAddTask: (task, description, dueDate) {
            addTask(task, description, dueDate);
            // Navigator.of(context).pop();
          },
          isEditing: false,
          changeTask: '',
          changedescription: '',
        );
      },
    );
  }

  //function for task editing
  Future<void> _editTask(BuildContext context, int index) async {
    if (index >= 0 && index < myTasks.length) {
      final editedTask = await showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            onAddTask: (task, description, dueDate) =>
                editTask(index, task, description, dueDate),
            changeTask: myTasks[index].task,
            changedescription: myTasks[index].description,
            isEditing: true,
          );
        },
      );

      if (editedTask != null) {
        setState(() {
          myTasks[index] = myTasks[index].copyWith(
            task: editedTask.task,
            description: editedTask.description,
          );
          isEditing = false;
        });
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // print(myTasks);
    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor: Colors.deepPurple.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(elevation: 0.0, actions: const [
          Spacer(),
        ]),
      ),
      body: Stack(
        children: [
          Visibility(
            visible: myTasks.isNotEmpty,
            child: const MyAnimation(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 14, right: 14),
            child: Column(
              children: [
                Expanded(
                  child: myTasks.isEmpty
                      ? _buildEmptyListWidget()
                      : AnimatedList(
                          key: _listKey,
                          physics: const BouncingScrollPhysics(),
                          initialItemCount: myTasks.length,
                          itemBuilder: (context, index, animation) {
                            if (index >= 0 && index < myTasks.length) {
                              final task = myTasks[index];
                              return SizeTransition(
                                sizeFactor: animation,
                                child: TaskList(
                                  index: index,
                                  task: task.task,
                                  description: task.description,
                                  isDone: task.isDone,
                                  onChanged: (value) =>
                                      checkBoxState(value!, index),
                                  removeTask: removeTask,
                                  onLongPress: () {
                                    setState(() {
                                      isEditing = true;
                                      editingIndex = index;
                                    });
                                    _editTask(context, index);
                                  },
                                  dueDate: task.dueDate,
                                ),
                              );
                            } else {
                              // Return an empty container if the index is out of range
                              return Container();
                            }
                          },
                        ),
                ),
              ],
            ),
          ),

          //action button to add task
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                _onAddButtonTap(context);
              },
              child: LottieBuilder.asset(
                "assets/add.json",
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
