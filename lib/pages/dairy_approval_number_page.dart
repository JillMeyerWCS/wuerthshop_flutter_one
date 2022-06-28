import 'package:flutter/material.dart';
import 'package:wuerthshop_part_1/widgets/dairy_search_form.dart';
import '../model/dairy_factory.dart';
import '../widgets/dairy_identification_badge.dart';

class DairyApprovalNumbersPage extends StatelessWidget {
  final List<DairyFactory> allFactories;
  const DairyApprovalNumbersPage({Key? key, required this.allFactories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DairySearchForm(
      allFactories: allFactories,
      builder: (controller) => DairyIdentificationBadge(controller: controller),
      filter: (factory, text) => factory.approvalNumber.contains(text),
    );
  }
}
