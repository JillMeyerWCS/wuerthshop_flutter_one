import 'package:flutter/material.dart';
import 'package:wuerthshop_part_1/widgets/app_wrapper.dart';

import 'model/app_state.dart';
import 'pages/dairy_approval_number_page.dart';
import 'pages/dairy_name_search_page.dart';
import 'pages/saved_dairy_page.dart';

class CustomTab {
  CustomTab({required this.title, required this.builder});
  final String title;
  final Widget builder;
}

final tabs = [
  CustomTab(title: "Search by name", builder: const DairyNameSearchPage()),
  CustomTab(title: "Search by number", builder: const DairyApprovalNumbersPage()),
  CustomTab(title: "Saved", builder: const SavedDairyPage())
];

class MyApp extends StatelessWidget {
  final AppState initialAppState;
  const MyApp({Key? key, required this.initialAppState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
        initialState: initialAppState,
        builder: (context) {
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
                        bottom: TabBar(
                            tabs:
                                tabs.map((e) => Tab(text: e.title)).toList())),
                    body: TabBarView(
                        children: tabs.map((e) => e.builder).toList())),
              ));
        });
  }
}
