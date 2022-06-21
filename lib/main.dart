import 'package:flutter/material.dart';
import 'package:wuerthshop_part_1/util/dairy_factory_service.dart';
import 'package:xml/xml.dart';

import 'pages/dairy_approval_number_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: MaterialApp(
        title: 'Flutter Würthshop Part One',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home: const DairyApprovalNumbersPage(),
      ),
    );
  }
}

class LoadingWidget extends StatefulWidget {
  final Widget child;

  const LoadingWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  late final Future<String> _fileLoadingPromise;

  @override
  void initState() {
    super.initState();

    _fileLoadingPromise = Future.delayed(const Duration(seconds: 2))
        .then((value) =>
            DefaultAssetBundle.of(context).loadString("assets/codes.xml"))
        .then((value) {
      setState(() {
        var doc = XmlDocument.parse(value);
        DairyFactoryService().parseFromXmlDoc(doc);
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fileLoadingPromise,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something has gone wrong"));
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return widget.child;
        }));
  }
}
