import 'package:flutter/material.dart';

class DairyFactoryDisplay extends StatelessWidget {
  const DairyFactoryDisplay({
    Key? key,
    required this.name,
    required this.approvalNumber,
  }) : super(key: key);

  final String name;
  final String approvalNumber;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.factory_outlined),
      title: Text(name),
      subtitle: Text(approvalNumber),
    );
  }
}
