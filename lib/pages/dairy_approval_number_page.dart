import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wuerthshop_part_1/model/app_actions.dart';
import 'package:wuerthshop_part_1/widgets/dairy_search_form.dart';
import '../model/app_state.dart';
import '../widgets/dairy_identification_badge.dart';

class DairyApprovalNumbersPage extends StatelessWidget {
  const DairyApprovalNumbersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, appState) {
      return DairySearchForm(
        intitialText: appState.state.idSearch,
        saveSearch: (String search) =>
            appState.dispatch(IdSearchAction(search)),
        builder: (controller) =>
            DairyIdentificationBadge(controller: controller),
        filter: (factory, text) => factory.approvalNumber.contains(text),
      );
    });
  }
}
