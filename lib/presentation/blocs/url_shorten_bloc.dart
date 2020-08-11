import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_shorten/core/result.dart';
import 'package:url_shorten/core/services.dart';
import 'package:url_shorten/data/apis/shortener_apis.dart';
import 'package:url_shorten/data/repositories/url_shortening_repositories.dart';
import 'package:url_shorten/presentation/blocs/url_shortening_state.dart';
import 'package:dartx/dartx.dart';

class UrlShortenBloc {
  final _state = BehaviorSubject<UrlShorteningState>.seeded(UrlShorteningState.idle());

  Stream<UrlShorteningState> get state => _state.stream;

  bool _canceled = false;

  UrlShortenerApi _api;

  UrlShortenerApi get api => _api;

  Future<bool> changeProvider(UrlShortenerApi api) async {
    _api = api;
    return true;
  }

  Future<void> shorten(String url, [BuildContext context]) async {
    if (_state.value == UrlShorteningState.loading()) {
      _showMessage(context, 'Shortener is already busy');
      return;
    }

    _state.add(UrlShorteningState.loading());
    final repo = services<UrlShorteningRepository>();

    final result = await repo.shorten(url, service: api);

    if (_canceled) {
      _canceled = false;
      _state.add(UrlShorteningState.idle());
      return;
    }

    if (result.isSuccess) {
      _state.add(UrlShorteningState.loaded(shortUrl: result.value));
    } else {
      if (result.error is NetworkError) {
        _state.add(UrlShorteningState.failed(message: 'Failed to contact shortening service'));
      } else {
        _state.add(UrlShorteningState.failed(message: 'An error occurred vehicle shortening'));
      }
    }
  }

  void _showMessage(BuildContext context, String message) {
    context != null
        ? Flushbar(
            duration: 2.seconds,
            animationDuration: 200.milliseconds,
            forwardAnimationCurve: Curves.fastOutSlowIn,
            margin: EdgeInsets.all(8),
            borderRadius: 8,
            message: message,
          ).show(context)
        : print(message);
  }

  void reset() {
    _state.add(UrlShorteningState.idle());
  }

  void cancel() async {
    if (_state.value == UrlShorteningState.loading()) {
      _canceled = true;
    }
    _state.add(UrlShorteningState.idle());
  }
}
