import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:wuerthshop_part_1/model/app_actions.dart';
import 'package:wuerthshop_part_1/widgets/dairy_search_form.dart';
import '../model/app_state.dart';
import '../widgets/dairy_identification_badge.dart';

class _Factory extends VmFactory<AppState, DairyApprovalNumbersPage> {
  _Factory(widget) : super(widget);

  @override
  DairyApprovalNumbersPageVm fromStore() => DairyApprovalNumbersPageVm(
      initialText: state.idSearch,
      saveSearch: (String search) => dispatch(IdSearchAction(search)));
}

class DairyApprovalNumbersPageVm extends Vm {
  final String initialText;
  final void Function(String) saveSearch;

  DairyApprovalNumbersPageVm(
      {required this.initialText, required this.saveSearch})
      : super(equals: [initialText]);
}

class DairyApprovalNumbersPage extends StatelessWidget {
  const DairyApprovalNumbersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DairyApprovalNumbersPageVm>(
        vm: () => _Factory(this),
        builder: (context, vm) {
          return DairySearchForm(
            intitialText: vm.initialText,
            saveSearch: vm.saveSearch,
            builder: (controller) =>
                DairyIdentificationBadge(controller: controller),
            filter: (factory, text) => factory.approvalNumber.contains(text),
          );
        });
  }
}
