import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_list/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, Key? hkey});

  final Color customGreen = const Color(0xff03C988);
  final Color customRed = const Color(0xffF45050);
  final Color customYellow = const Color(0xff03C988);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple.shade100,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Prajwal Dudhatkar'),
            accountEmail: Text('workwithprajwal@yahoo.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgi.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Iconsax.home),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 15),
            ),
            selected: true,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Iconsax.message_question),
            title: const Text(
              'Need Help?',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
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
                          const Text(
                              '- Swipe left on the task and tap "Delete".'),
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.setting),
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              const MySettings();
            },
          ),
        ],
      ),
    );
  }
}
