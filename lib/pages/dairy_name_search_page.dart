import 'package:flutter/material.dart';
import 'package:wuerthshop_part_1/model/dairy_factory.dart';
import '../widgets/dairy_search_form.dart';

class DairyNameSearchPage extends StatelessWidget {
  final List<DairyFactory> allFactories;
  final Set<DairyFactory> savedFactories;
  final Function(DairyFactory) addFactory;
  final Function(DairyFactory) removeFactory;
  const DairyNameSearchPage(
      {Key? key,
      required this.allFactories,
      required this.savedFactories,
      required this.addFactory,
      required this.removeFactory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DairySearchForm(
      allFactories: allFactories,
      savedFactories: savedFactories,
      addFactory: addFactory,
      removeFactory: removeFactory,
      builder: (controller) => TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Type..."),
      ),
      filter: (factory, text) => factory.name.contains(text),
    );
  }
}
