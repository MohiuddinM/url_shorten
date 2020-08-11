import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_shorten/core/services.dart';
import 'package:url_shorten/url_shorten.dart';

import 'core/analytics.dart';
import 'core/navigator.dart';
import 'presentation/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Crashlytics.instance.enableInDevMode = false;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  await setupServices();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator.navigatorKey,
      navigatorObservers: <NavigatorObserver>[Analytics.observer],
      initialRoute: '/',
      onGenerateRoute: generateRoute,
      theme: ThemeData(primaryColor: Colors.deepPurple),
      onGenerateTitle: (context) => 'URL Shorten',
      localizationsDelegates: [
        //TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', 'US')],
      home: UrlShorten(),
    );
  }
}
