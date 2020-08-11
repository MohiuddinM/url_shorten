import 'package:flutter/material.dart';
import 'past_urls_page.dart';
import 'shorten_url_page.dart';

export 'past_urls_page.dart';
export 'shorten_url_page.dart';

const String shortenUrlsPage = '/shorten-url';
const String pastUrlsPage = '/past-urls';

Route<dynamic> generateRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => getRouteWidget(settings.name, settings.arguments));
}

Widget getRouteWidget(String name, Map<String, Object> args) {
  switch (name) {
    case pastUrlsPage:
      return PastUrlsPage();
    case shortenUrlsPage:
    default:
      return ShortenUrlsPage();
  }
}
