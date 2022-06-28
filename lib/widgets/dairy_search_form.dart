import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:wuerthshop_part_1/model/app_actions.dart';

import '../model/app_state.dart';
import '../model/dairy_factory.dart';
import 'dairy_factory_display.dart';

class _Factory extends VmFactory<AppState, DairySearchForm> {
  _Factory(widget) : super(widget);

  @override
  DairySearchFormVm fromStore() => DairySearchFormVm(
      allFactories: state.allFactories,
      savedFactories: state.savedFactories,
      add: (DairyFactory factory) => dispatch(AddToSaved(factory)),
      remove: (DairyFactory factory) => dispatch(RemoveFromSaved(factory)));
}

class DairySearchFormVm extends Vm {
  final List<DairyFactory> allFactories;
  final Set<DairyFactory> savedFactories;
  final void Function(DairyFactory) add;
  final void Function(DairyFactory) remove;
  DairySearchFormVm(
      {required this.allFactories,
      required this.savedFactories,
      required this.add,
      required this.remove})
      : super(equals: [allFactories, savedFactories]);
}

class DairySearchForm extends StatefulWidget {
  final Widget Function(TextEditingController) builder;
  final bool Function(DairyFactory, String) filter;
  final Function(String) saveSearch;
  final String intitialText;

  const DairySearchForm(
      {Key? key,
      required this.builder,
      required this.filter,
      required this.saveSearch,
      this.intitialText = ''})
      : super(key: key);

  @override
  State<DairySearchForm> createState() => _DairySearchFormState();
}

class _DairySearchFormState extends State<DairySearchForm> {
  late final TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: widget.intitialText);
    _inputController.addListener(() {
      widget.saveSearch(_inputController.text);
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.builder(
            _inputController,
          ),
        ),
        Expanded(
          child: buildList(),
        ),
      ],
    );
  }

  Widget buildList() {
    return StoreConnector<AppState, DairySearchFormVm>(
        vm: () => _Factory(widget),
        builder: (context, vm) {
          return ListView(
              children: vm.allFactories
                  .where((element) =>
                      widget.filter(element, _inputController.text))
                  .map((factory) => DairyFactoryDisplay(
                        name: factory.name,
                        approvalNumber: factory.approvalNumber,
                        trailing: vm.savedFactories.contains(factory)
                            ? IconButton(
                                onPressed: () => vm.remove(factory),
                                icon: const Icon(Icons.favorite))
                            : IconButton(
                                onPressed: () => vm.add(factory),
                                icon: const Icon(Icons.favorite_outline)),
                      ))
                  .toList());
        });
  }
}
