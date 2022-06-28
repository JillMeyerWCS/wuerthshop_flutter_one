import 'package:flutter/material.dart';

class DairyFactoryDisplay extends StatelessWidget {
  final Widget trailing;
  const DairyFactoryDisplay({
    Key? key,
    required this.name,
    required this.approvalNumber,
    this.trailing = const Icon(Icons.launch),
    this.onTap,
  }) : super(key: key);

  final String name;
  final String approvalNumber;
  final Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.factory_outlined),
      trailing: trailing,
      title: Text(name),
      subtitle: Text(approvalNumber),
      onTap: onTap != null ? () => onTap!(name) : null,
    );
  }
}
