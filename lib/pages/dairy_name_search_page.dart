import 'package:flutter/material.dart';
import '../widgets/dairy_search_form.dart';

class DairyNameSearchPage extends StatelessWidget {
  const DairyNameSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DairySearchForm(
      builder: (controller) => TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Type..."),
      ),
      filter: (factory, text) => factory.name.contains(text),
    );
  }
}
