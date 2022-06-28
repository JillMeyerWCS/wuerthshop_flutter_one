import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:wuerthshop_part_1/model/app_actions.dart';
import '../model/app_state.dart';
import '../widgets/dairy_search_form.dart';

class _Factory extends VmFactory<AppState, DairyNameSearchPage> {
  _Factory(widget) : super(widget);

  @override
  DairyNameSearchPageVm fromStore() => DairyNameSearchPageVm(
      initialText: state.nameSearch,
      saveSearch: (String search) => dispatch(NameSearchAction(search)));
}

class DairyNameSearchPageVm extends Vm {
  final String initialText;
  final void Function(String) saveSearch;

  DairyNameSearchPageVm({required this.initialText, required this.saveSearch})
      : super(equals: [initialText]);
}

class DairyNameSearchPage extends StatelessWidget {
  const DairyNameSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DairyNameSearchPageVm>(
        vm: () => _Factory(this),
        builder: (context, vm) {
          return DairySearchForm(
            intitialText: vm.initialText,
            saveSearch: vm.saveSearch,
            builder: (controller) => TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Type..."),
            ),
            filter: (factory, text) => factory.name.contains(text),
          );
        });
  }
}
