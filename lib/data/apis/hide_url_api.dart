import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_shorten/core/network_error.dart';
import 'package:url_shorten/data/apis/shortener_apis.dart';

class HideUrlApi implements UrlShortenerApi {
  final serviceName = 'Hide Url';
  final _url = 'https://hideuri.com/api/v1/shorten';

  @override
  Future<String> shorten(String url) async {
    await Future.delayed(Duration(seconds: 1));
    return 'conv = ' + url;
    final response = await http.post(Uri.parse(_url), body: 'url=' + url);

    if (response.statusCode == 200) {
      final map = jsonDecode(response.body);
      return map['result_url'];
    } else {
      throw NetworkError(response.statusCode, response.body);
    }
  }
}
