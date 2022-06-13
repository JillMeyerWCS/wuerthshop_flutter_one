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
      body: Column(
        children: const [
        DairyFactoryDisplay(
          name: "Ehrmann GmbH Oberschönegg im Allgäu",
          approvalNumber: "BY 77727",
        ),
        DairyFactoryDisplay(
          name: "Allgäu Hof Müller - Milchmanufaktur GmbH & Co.KG",
          approvalNumber: "BW 08119",
        ),
      ]),
    );
  }
}

class DairyFactoryDisplay extends StatelessWidget {
  const DairyFactoryDisplay({
    Key? key,
    required this.name,
    required this.approvalNumber,
  }) : super(key: key);

  final String name;
  final String approvalNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.factory_outlined),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text(approvalNumber, style: const TextStyle(fontSize: 14.0))
            ],
          ),
        ),
      ],
    );
  }
}
