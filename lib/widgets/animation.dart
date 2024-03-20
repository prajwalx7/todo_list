import 'package:flutter/material.dart';

class MyAnimation extends StatelessWidget {
  const MyAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            child: Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
