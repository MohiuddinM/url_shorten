import 'package:flutter/material.dart';

class PastUrlsPage extends StatefulWidget {
  const PastUrlsPage({super.key});

  @override
  _PastUrlsPageState createState() => _PastUrlsPageState();
}

class _PastUrlsPageState extends State<PastUrlsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 64.0),
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
