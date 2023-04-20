import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_shorten/data/enums/shortening_services.dart';

part 'url_shortener_form_state.freezed.dart';

@freezed
class UrlShortenerFormState with _$UrlShortenerFormState {
  const factory UrlShortenerFormState({
    required String url,
    required ShorteningService service,
    required GlobalKey<FormState> formKey,
  }) = _UrlShortenerFormState;
}
