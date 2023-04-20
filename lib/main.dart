import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_shorten/setup.dart';
import 'package:url_shorten/url_shorten.dart';

import 'core/analytics.dart';

void main() async {
  runApp(
    FutureBuilder<bool>(
      future: setup(),
      builder: (context, s) {
        if (s.hasData && (s.data ?? false)) {
          return ProviderScope(child: App());
        }

        return Container();
      },
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorObservers: <NavigatorObserver>[Analytics.observer],
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
