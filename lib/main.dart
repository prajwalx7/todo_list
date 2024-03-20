import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xff222831),
          scaffoldBackgroundColor: const Color(0xffEEEEEE),
          textTheme: GoogleFonts.poppinsTextTheme()),
    );
  }
}
