import 'package:flutter/material.dart';

import 'pages/dairy_approval_number_page.dart';
import 'pages/dairy_name_search_page.dart';
import 'pages/saved_dairy_page.dart';

class CustomTab {
  CustomTab({required this.title, required this.body});
  final String title;
  final Widget body;
}

final tabs = [
  CustomTab(title: "Search by name", body: const DairyNameSearchPage()),
  CustomTab(title: "Search by number", body: const DairyApprovalNumbersPage()),
  CustomTab(title: "Saved", body: const SavedDairyPage())
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Würthshop Part Three',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            appBar: AppBar(
                title: const Text("Dairy Factory Lookup"),
                bottom:
                    TabBar(tabs: tabs.map((e) => Tab(text: e.title)).toList())),
            body: TabBarView(children: tabs.map((e) => e.body).toList()),
          )),
    );
  }
}
