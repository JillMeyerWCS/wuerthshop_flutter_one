import 'package:flutter/material.dart';

import '../model/dairy_factory.dart';
import 'dairy_factory_display.dart';

class DairySearchForm extends StatefulWidget {
  final Widget Function(TextEditingController) builder;
  final bool Function(DairyFactory, String) filter;
  final List<DairyFactory> allFactories;

  const DairySearchForm(
      {Key? key,
      required this.builder,
      required this.filter,
      required this.allFactories})
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
                  .map((e) => DairyFactoryDisplay(
                        name: e.name,
                        approvalNumber: e.approvalNumber,
                      ))
                  .toList()),
        ),
      ],
    );
  }

  void _updateResults() {
    setState(() {
      _searchResult = widget.allFactories
          .where((e) => widget.filter(e, _inputController.text))
          .take(10)
          .toList()
        ..sort();
    });
  }
}
