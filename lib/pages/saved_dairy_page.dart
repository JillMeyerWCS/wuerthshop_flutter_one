import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wuerthshop_part_1/model/dairy_factory.dart';
import '../widgets/dairy_factory_display.dart';

class SavedDairyPage extends StatelessWidget {
  final List<DairyFactory> savedFactories;
  const SavedDairyPage({Key? key, required this.savedFactories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (savedFactories.isEmpty) {
      return Center(
          child: Text("You didn't save any factories yet",
              style: Theme.of(context).textTheme.headline2));
    }
    return ListView.builder(
      itemCount: savedFactories.length,
      itemBuilder: (context, index) => DairyFactoryDisplay(
          name: savedFactories[index].name,
          approvalNumber: savedFactories[index].approvalNumber,
          onTap: _launchWebSearch),
    );
  }

  void _launchWebSearch(String name) {
    final Uri search =
        Uri.parse("https://duckduckgo.com/?q=${Uri.encodeComponent(name)}");
    launchUrl(search);
  }
}
