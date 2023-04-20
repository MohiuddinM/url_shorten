import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_shorten/data/enums/shortening_services.dart';
import 'package:url_shorten/data/models/url_shortener_form_state.dart';

class UrlShortenerFormStateNotifier
    extends StateNotifier<UrlShortenerFormState> {
  UrlShortenerFormStateNotifier()
      : super(
          UrlShortenerFormState(
            url: '',
            service: ShorteningService.hideUrl,
            formKey: GlobalKey<FormState>(),
          ),
        );

  set url(String url) => state = state.copyWith(url: url);

  set service(ShorteningService service) => state = state.copyWith(
        service: service,
      );
}

final urlShortenerFormProvider =
    StateNotifierProvider<UrlShortenerFormStateNotifier, UrlShortenerFormState>(
        (ref) {
  return UrlShortenerFormStateNotifier();
});
