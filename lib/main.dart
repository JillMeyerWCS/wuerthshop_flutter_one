import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Würthshop Part One',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DairyApprovalNumbersPage(),
    );
  }
}

class DairyApprovalNumbersPage extends StatelessWidget {
  const DairyApprovalNumbersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dairy approval number app")),
      body: const Center(child: Text("List of approval numbers")),
    );
  }
}
