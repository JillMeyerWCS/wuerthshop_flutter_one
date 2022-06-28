import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wuerthshop_part_1/model/app_actions.dart';

import '../model/app_state.dart';
import '../model/dairy_factory.dart';
import 'dairy_factory_display.dart';

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
    return StoreBuilder<AppState>(builder: (context, store) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.builder(
              _inputController,
            ),
          ),
          Expanded(
            child: ListView(
                children: store.state.allFactories
                    .where((element) =>
                        widget.filter(element, _inputController.text))
                    .map((factory) => DairyFactoryDisplay(
                          name: factory.name,
                          approvalNumber: factory.approvalNumber,
                          trailing: store.state.savedFactories.contains(factory)
                              ? IconButton(
                                  onPressed: () =>
                                      store.dispatch(RemoveFromSaved(factory)),
                                  icon: const Icon(Icons.favorite))
                              : IconButton(
                                  onPressed: () =>
                                      store.dispatch(AddToSaved(factory)),
                                  icon: const Icon(Icons.favorite_outline)),
                        ))
                    .toList()),
          ),
        ],
      );
    });
  }
}
