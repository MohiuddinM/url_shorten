import 'dart:io';

import 'package:url_shorten/core/key_value_store.dart';
import 'package:url_shorten/core/result.dart';
import 'package:url_shorten/core/url_shorten_logger.dart';
import 'package:url_shorten/data/apis/shortener_apis.dart';
import 'package:url_shorten/data/models/shortened_url.dart';

class UrlShorteningRepository {
  static const _log = UrlShortenLogger('UrlShorteningRepository');

  final KeyValueStore _store;
  final List<UrlShortenerApi> apis;

  UrlShorteningRepository(KeyValueStore databaseStore, this.apis) : _store = databaseStore;

  Future<Result<ShortenedUrl>> shorten(String url, {UrlShortenerApi service}) async {
    try {
      final past = await _store.getString(url, def: '');
      if (past != '') return Result.ok(ShortenedUrl(url, past));
    } catch (e) {
      _log.warning('past urls database failed');
    }

    if (service == null) {
      if (apis?.isEmpty ?? true) {
        return Result.error(NetworkError());
      }

      service = apis.first;
    }

    try {
      final short = await service.shorten(url);

      await _store.setString(url, short);

      return Result.ok(ShortenedUrl(url, short));
    } on SocketException {
      return Result.error(NetworkError());
    } catch (e) {
      return Result.error(e);
    }
  }
}
