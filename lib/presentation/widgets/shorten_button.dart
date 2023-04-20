import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_shorten/presentation/providers/short_url_provider.dart';
import 'package:url_shorten/presentation/providers/url_shortening_form_provider.dart';

class ShortenButton extends ConsumerWidget {
  const ShortenButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(urlShortenerFormProvider);
    final shortUrl = ref.watch(shortUrlProvider);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.deepPurple,
      ),
      onPressed: () {
        final isValid = formState.formKey.currentState?.validate() ?? false;

        if (isValid) {
          ref.invalidate(shortUrlProvider);
        }
      },
      child: shortUrl.when(
        skipError: true,
        data: (_) => Text('Shorten', style: TextStyle(color: Colors.white)),
        error: (_, __) => SizedBox.shrink(),
        loading: () => const SpinKitCircle(
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
