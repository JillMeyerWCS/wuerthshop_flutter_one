import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/dairy_factory_service.dart';
import '../widgets/dairy_factory_display.dart';

class SavedDairyPage extends StatelessWidget {
  const SavedDairyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final factories = DairyFactoryService().all;
    return ListView.builder(
      itemCount: factories.length,
      itemBuilder: (context, index) => DairyFactoryDisplay(
          name: factories[index].name,
          approvalNumber: factories[index].approvalNumber,
          onTap: _launchWebSearch),
    );
  }

  void _launchWebSearch(String name) {
    final Uri search =
        Uri.parse("https://duckduckgo.com/?q=${Uri.encodeComponent(name)}");
    launchUrl(search);
  }
}
