/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import '../main.dart';
*//*
class ConfigurationDisplay extends StatelessWidget {
  const ConfigurationDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
        BuildConfiguration.shared.apiKey,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}*//*

Future<void> main() async {


  // FirebaseCrashlytics.instance.crash();
 *//* BuildConfiguration.shared.environment = Environment.production;

  String mode = BuildConfiguration.shared.mode;

  if (kDebugMode) {
    print("Mode: $mode");
  }

  runApp(const MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ConfigurationDisplay(
        ),
      ),
    ),
  ));*//*
}*/




