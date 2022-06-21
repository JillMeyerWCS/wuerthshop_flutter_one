import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

import '../model/dairy_factory.dart';
import '../widgets/dairy_factory_display.dart';
import '../widgets/dairy_identification_badge.dart';

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
    _inputController.addListener(_updateResults);
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
                child: ListView(
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

  void _updateResults() {
    setState(() {
      _searchResult = _dairyFactories
          .where((element) =>
              element.approvalNumber.contains(_inputController.text))
          .take(10)
          .toList()
        ..sort();
    });
  }
}
