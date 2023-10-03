import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:task/task.dart';
import 'package:task/try.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'Favorite Quotes.dart';
import 'i18n/app_en.json.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => debugPrint("flutter firebase run sucessfully"));
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FirebaseCrashlytics.instance.crash();
  //runApp(const MaterialApp(home: APi1()));
 // runApp(const MaterialApp(home: Update()));
  runApp(const MaterialApp(home: FavoriteQuotesApp()));

}



/*
enum Environment {
  staging,
  production,
}
class BuildConfiguration {
  static final shared = BuildConfiguration();
  late Environment environment;

  // Define API keys for staging and production environments
  String get apiKey {
    switch (environment) {
      case Environment.staging:
        return "1234567890"; // Staging API key
      case Environment.production:
        return "0987654321"; // Production API key
    }
  }

  String get baseUrl {
    switch (environment) {
      case Environment.staging:
        return "https://staging-api.example.com?key=$apiKey";
      case Environment.production:
        return "https://api.example.com?key=$apiKey";
    }
  }

  String get socketUrl {
    switch (environment) {
      case Environment.staging:
        return "wss://staging-socket.example.com?key=$apiKey";
      case Environment.production:
        return "wss://socket.example.com?key=$apiKey";
    }
  }

  String get mode {
    switch (environment) {
      case Environment.staging:
        return "TEST";
      case Environment.production:
        return "PROD";
    }
  }

}
*/




/*void main() {
  BuildConfiguration.shared.environment = Environment.production;

  String baseUrl = BuildConfiguration.shared.baseUrl;
  String socketUrl = BuildConfiguration.shared.socketUrl;
  String mode = BuildConfiguration.shared.mode;

  print("Base URL: $baseUrl");
  print("Socket URL: $socketUrl");
  print("Mode: $mode");

  runApp(const MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ConfigurationDisplay(),
      ),
    ),
  ));
}*/




