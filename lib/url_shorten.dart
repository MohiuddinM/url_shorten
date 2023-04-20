import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_shorten/presentation/pages/past_urls_page.dart';
import 'package:url_shorten/presentation/pages/shorten_url_page.dart';
import 'package:url_shorten/presentation/widgets/main_navigation_bar.dart';

class UrlShorten extends StatefulWidget {
  @override
  _UrlShortenState createState() => _UrlShortenState();
}

class _UrlShortenState extends State<UrlShorten> {
  int index = 0;

  Widget buildPage() {
    switch (index) {
      case 1:
        return PastUrlsPage();
      case 0:
      default:
        return ShortenUrlsPage();
    }
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
      body: buildPage(),
      bottomNavigationBar: MainNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(
          () {
            index = i;
          },
        ),
      ),
    );
  }
}
