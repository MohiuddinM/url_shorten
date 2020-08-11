export 'hide_url_api.dart';
export 'isgd_api.dart';

abstract class UrlShortenerApi {
  String get serviceName;
  Future<String> shorten(String url);
}