import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:uvec/firebase_options.dart';

Future<void> init() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // todo: dependency injection, for services and such ig
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
