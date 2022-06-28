import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/app_state.dart';
import '../model/dairy_factory.dart';
import '../widgets/dairy_factory_display.dart';

class SavedDairyPage extends StatelessWidget {
  const SavedDairyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<DairyFactory>>(
        converter: (store) => store.state.savedFactories.toList(),
        builder: (context, savedFactories) {
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
        });
  }

  void _launchWebSearch(String name) {
    final Uri search =
        Uri.parse("https://duckduckgo.com/?q=${Uri.encodeComponent(name)}");
    launchUrl(search);
  }
}
