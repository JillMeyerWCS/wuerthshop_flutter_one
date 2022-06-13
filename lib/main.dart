import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

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
      body: const DairySearchForm(),
    );
  }
}

class DairySearchForm extends StatefulWidget {
  const DairySearchForm({Key? key}) : super(key: key);

  @override
  State<DairySearchForm> createState() => _DairySearchFormState();
}

class DairyFactory implements Comparable<DairyFactory> {
  final String name;
  final String approvalNumber;

  DairyFactory({required this.name, required this.approvalNumber});

  DairyFactory.parseFromXmlNode(XmlNode node)
      : name = nameFromXmlNode(node),
        approvalNumber = approvalNumberFromXmlNode(node);

  static String nameFromXmlNode(XmlNode node) =>
      node.getElement("bvl:name")?.text ?? 'no name';

  static String approvalNumberFromXmlNode(XmlNode xml) {
    final newId = xml.getElement("bvl:zulassungsnummer");
    String? id;
    if (newId != null && newId.innerText.trim().isNotEmpty) {
      id =
          '${newId.getElement("bvl:bundesland")?.text} ${newId.getElement("bvl:nummer")?.text}';
    } else {
      id = xml
          .getElement("bvl:taetigkeit")
          ?.getElement("bvl:alteZulassungsnummer")
          ?.innerText;
    }
    return id ?? 'unknown';
  }

  static List<DairyFactory> parseFromXmlDoc(XmlDocument codes) => codes
      .findAllElements("bvl:betrieb")
      .map(DairyFactory.parseFromXmlNode)
      .toList();

  @override
  int compareTo(DairyFactory other) {
    // use name for comparison
    return name.compareTo(other.name);
  }
}

class _DairySearchFormState extends State<DairySearchForm> {
  late final Future<String> _fileLoadingPromise;
  final _inputController = TextEditingController();
  List<DairyFactory> _dairyFactories = <DairyFactory>[];
  List<DairyFactory> _searchResult = <DairyFactory>[];

  @override
  void initState() {
    super.initState();
    _fileLoadingPromise = Future.delayed(const Duration(seconds: 2))
        .then((value) =>
            DefaultAssetBundle.of(context).loadString("assets/codes.xml"))
        .then((value) {
      setState(() {
        var doc = XmlDocument.parse(value);
        _dairyFactories = DairyFactory.parseFromXmlDoc(doc);
        _searchResult = _dairyFactories.take(10).toList();
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fileLoadingPromise,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something has gone wrong"));
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return Row(
            children: [
              DairyIdentificationBadge(
                controller: _inputController,
              ),
              Expanded(
                child: Column(
                    children: _searchResult
                        .map((e) => DairyFactoryDisplay(
                              name: e.name,
                              approvalNumber: e.approvalNumber,
                            ))
                        .toList()),
              ),
            ],
          );
        });
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
