import 'package:flutter/material.dart';
import 'package:wuerthshop_part_1/widgets/app_wrapper.dart';

import '../model/dairy_factory.dart';
import 'dairy_factory_display.dart';

class DairySearchForm extends StatefulWidget {
  final Widget Function(TextEditingController) builder;
  final bool Function(DairyFactory, String) filter;
  final Function(DairyFactory) addFactory;
  final Function(DairyFactory) removeFactory;

  const DairySearchForm(
      {Key? key,
      required this.builder,
      required this.filter,
      required this.addFactory,
      required this.removeFactory})
      : super(key: key);

  @override
  State<DairySearchForm> createState() => _DairySearchFormState();
}

class _DairySearchFormState extends State<DairySearchForm> {
  final _inputController = TextEditingController();
  List<DairyFactory> _searchResult = [];

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_updateResults);
  }

  @override
  Widget build(BuildContext context) {
    final appState = InheritedAppState.of(context)!.state;
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
              children: _searchResult
                  .map((factory) => DairyFactoryDisplay(
                        name: factory.name,
                        approvalNumber: factory.approvalNumber,
                        trailing: appState.savedFactories.contains(factory)
                            ? IconButton(
                                onPressed: () => widget.removeFactory(factory),
                                icon: const Icon(Icons.favorite))
                            : IconButton(
                                onPressed: () => widget.addFactory(factory),
                                icon: const Icon(Icons.favorite_outline)),
                      ))
                  .toList()),
        ),
      ],
    );
  }

  void _updateResults() {
    setState(() {
      final appState = InheritedAppState.of(context)!.state;
      _searchResult = appState.allFactories
          .where((e) => widget.filter(e, _inputController.text))
          .take(10)
          .toList()
        ..sort();
    });
  }
}
