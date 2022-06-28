import 'package:flutter/material.dart';
import 'package:wuerthshop_part_1/widgets/dairy_search_form.dart';
import '../model/dairy_factory.dart';
import '../widgets/dairy_identification_badge.dart';

class DairyApprovalNumbersPage extends StatelessWidget {
  const DairyApprovalNumbersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DairySearchForm(
      builder: (controller) => DairyIdentificationBadge(controller: controller),
      filter: (factory, text) => factory.approvalNumber.contains(text),
    );
  }
}
