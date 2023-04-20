import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/short_url_provider.dart';
import '../providers/url_shortening_form_provider.dart';

class CancelButton extends ConsumerWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.watch(urlShortenerFormProvider.notifier);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        formNotifier.url = '';
        ref.invalidate(shortUrlProvider);
      },
      child: Text('Clear'),
    );
    ;
  }
}
