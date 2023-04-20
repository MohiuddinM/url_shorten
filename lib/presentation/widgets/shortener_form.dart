import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/validator.dart';
import '../providers/url_shortening_form_provider.dart';

class ShortenerForm extends HookConsumerWidget {
  const ShortenerForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlController = useTextEditingController();
    final formNotifier = ref.watch(urlShortenerFormProvider.notifier);
    final formState = ref.watch(urlShortenerFormProvider);
    final formWidth = MediaQuery.of(context).size.width - 48;

    ref.listenManual(urlShortenerFormProvider, (previous, next) {
      if (next.url.isEmpty) {
        urlController.text = '';
      }
    });

    return Form(
      key: formState.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 65,
          width: formWidth - 16,
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: TextFormField(
              controller: urlController,
              onChanged: (s) => formNotifier.url = s,
              validator: validateUrl,
              keyboardType: TextInputType.url,
              maxLines: 1,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: 'URL',
                icon: Icon(Icons.link, size: 20),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
