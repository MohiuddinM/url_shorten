import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_shorten/data/apis/shortener_apis.dart';
import 'package:url_shorten/presentation/providers/url_shortening_form_provider.dart';

import '../../data/enums/shortening_services.dart';

final shortUrlProvider = FutureProvider<String>((ref) async {
  final formState = ref.read(urlShortenerFormProvider);

  if (formState.url.isEmpty) {
    return '';
  }

  late final UrlShortenerApi api;
  switch (formState.service) {
    case ShorteningService.hideUrl:
      api = HideUrlApi();
      break;
    case ShorteningService.isGd:
      api = IsGdApi();
      break;
  }

  return api.shorten(formState.url);
});
