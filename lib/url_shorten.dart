import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_shorten/presentation/widgets/main_navigation_bar.dart';

import 'core/services.dart';
import 'presentation/pages/pages.dart';

class UrlShorten extends StatefulWidget {
  @override
  _UrlShortenState createState() => _UrlShortenState();
}

class _UrlShortenState extends State<UrlShorten> {
  Widget buildBody() {
    return Container(
      child: Navigator(
        key: mainPageNavigatorState,
        initialRoute: '/',
        onGenerateRoute: generateRoute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Url Shorten',
          style: GoogleFonts.varelaRound(fontWeight: FontWeight.bold),
        ),
      ),
      body: buildBody(),
      bottomNavigationBar: MainNavigationBar(),
    );
  }
}
