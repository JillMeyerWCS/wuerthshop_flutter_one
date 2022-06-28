import 'package:flutter/material.dart';
import '../widgets/app_wrapper.dart';
import '../widgets/dairy_search_form.dart';

class DairyNameSearchPage extends StatelessWidget {
  DairyNameSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = InheritedAppState.of(context)!;
    return DairySearchForm(
      intitialText: appState.state.nameSearch,
      saveSearch:  appState.saveNameSearch,
      builder: (controller) => TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Type..."),
      ),
      filter: (factory, text) => factory.name.contains(text),
    );
  }
}
