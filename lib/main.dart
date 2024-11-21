import '../screens/tabs.dart';
import 'package:flutter/material.dart';
import 'widdgets/expenses.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      home:  TabScreen(),
    );
  }
}
