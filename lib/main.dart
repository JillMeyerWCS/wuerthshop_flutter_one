import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';
import 'util/persistence.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final initialAppState = await loadAppState();
    runApp(MyApp(initialAppState: initialAppState));
  }, (exception, stackTrace) async {});
}
