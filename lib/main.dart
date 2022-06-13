import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      body: DairySearchForm(),
    );
  }
}

class DairySearchForm extends StatefulWidget {
  const DairySearchForm({Key? key}) : super(key: key);

  @override
  State<DairySearchForm> createState() => _DairySearchFormState();
}

class _DairySearchFormState extends State<DairySearchForm> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DairyIdentificationBadge(
          controller: _inputController,
        ),
        Expanded(
          child: Column(children: const [
            DairyFactoryDisplay(
              name: "Ehrmann GmbH Oberschönegg im Allgäu",
              approvalNumber: "BY 77727",
            ),
            DairyFactoryDisplay(
              name: "Allgäu Hof Müller - Milchmanufaktur GmbH & Co.KG",
              approvalNumber: "BW 08119",
            ),
          ]),
        ),
      ],
    );
  }
}

class DairyIdentificationBadge extends StatelessWidget {
  final TextEditingController controller;

  const DairyIdentificationBadge({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      fontSize: 24,
    );
    return SizedBox(
        width: 220,
        child: Center(
            child: Container(
          width: 180,
          height: 120,
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.elliptical(120, 80))),
          child: DefaultTextStyle.merge(
            style: textStyle,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("DE"),
              TextField(
                textAlign: TextAlign.center,
                style: textStyle,
                controller: controller,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: "App. Nr."),
              ),
              const Text("EG")
            ]),
          ),
        )));
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
