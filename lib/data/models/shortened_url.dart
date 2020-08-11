import 'package:equatable/equatable.dart';

class ShortenedUrl extends Equatable {
  final String url, shortenedUrl, shortenerName;

  const ShortenedUrl(this.url, this.shortenedUrl, [this.shortenerName = 'Unknown']);

  @override
  List<Object> get props => [url, shortenedUrl];
}
