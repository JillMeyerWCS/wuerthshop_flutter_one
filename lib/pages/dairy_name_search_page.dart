import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wuerthshop_part_1/model/app_actions.dart';
import '../model/app_state.dart';
import '../widgets/dairy_search_form.dart';

class DairyNameSearchPage extends StatelessWidget {
  const DairyNameSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, appState) {
      return DairySearchForm(
        intitialText: appState.state.nameSearch,
        saveSearch: (String search) =>
            appState.dispatch(NameSearchAction(search)),
        builder: (controller) => TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Type..."),
        ),
        filter: (factory, text) => factory.name.contains(text),
      );
    });
  }
}
