import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:sleep/src/app.dart';

import 'src/utils/http_overrides.dart';

Future main() async {
  /// Fix Error Http Request CERTIFICATE_VERIFY_FAILED
  /// This useful for error image network request
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}
