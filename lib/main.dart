import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';
import 'util/persistence.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await loadAppState();
    runApp(const MyApp());
  }, (exception, stackTrace) async {});
}
