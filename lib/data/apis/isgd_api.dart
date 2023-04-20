import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_shorten/core/network_error.dart';
import 'package:url_shorten/data/apis/shortener_apis.dart';

class IsGdApi implements UrlShortenerApi {
  final serviceName = 'IsGd';
  final _url = 'https://is.gd/create.php?format=json&url=';

  @override
  Future<String> shorten(String url) async {
    final uri = Uri.parse('$_url$url');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final map = jsonDecode(response.body);
      return map['shorturl'];
    } else {
      throw NetworkError(response.statusCode, response.body);
    }
  }
}
