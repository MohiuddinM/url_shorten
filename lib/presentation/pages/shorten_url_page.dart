import 'package:flutter/material.dart';
import 'package:url_shorten/presentation/widgets/short_url_box.dart';
import 'package:url_shorten/presentation/widgets/shorten_button.dart';
import '../widgets/cancel_button.dart';
import '../widgets/shortener_form.dart';

class ShortenUrlsPage extends StatefulWidget {
  const ShortenUrlsPage({super.key});

  @override
  _ShortenUrlsPageState createState() => _ShortenUrlsPageState();
}

class _ShortenUrlsPageState extends State<ShortenUrlsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ShortenerForm(),
                  ShortUrlBox(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CancelButton(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        ShortenButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
