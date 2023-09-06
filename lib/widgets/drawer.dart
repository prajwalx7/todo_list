import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_list/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, Key? hkey});

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
                image: AssetImage('assets/images/background.png'),
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
                    content: const SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('How to add a task:'),
                          Text('- Press the "+" icon.'),
                          Text('- Enter the task title and tap "Add".'),
                          SizedBox(height: 16),
                          Text('How to delete a task:'),
                          Text('- Swipe left on the task and tap "Delete".'),
                          SizedBox(height: 16),
                          Text('How to edit a task:'),
                          Text('- Long press on the task to edit it.'),
                          Text('- Make your changes and tap "Save".'),
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
