import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/short_url_provider.dart';

class ShortUrlBox extends ConsumerWidget {
  const ShortUrlBox({super.key});

  Widget buildShortUrl(BuildContext context, String shortUrl) {
    if (shortUrl.isEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(shortUrl),
          IconButton(
            iconSize: 16,
            icon: Icon(Icons.content_copy),
            onPressed: () async {
              final data = ClipboardData(text: shortUrl);
              await Clipboard.setData(data);
              final snackBar = SnackBar(content: Text('Copied to Clipboard'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ).animate().fade(duration: 400.milliseconds),
    );
  }

  Widget buildError(String error) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(error),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortUrl = ref.watch(shortUrlProvider);
    final formWidth = MediaQuery.of(context).size.width - 48;

    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        color: Colors.grey[300],
      ),
      duration: Duration(milliseconds: 400),
      curve: Curves.fastLinearToSlowEaseIn,
      width: formWidth - 64,
      child: shortUrl.when(
        skipLoadingOnRefresh: false,
        data: (s) => buildShortUrl(context, s),
        error: (e, _) => buildError(e.toString()),
        loading: () => LinearProgressIndicator(),
      ),
    );
  }
}
