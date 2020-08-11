import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_shorten/core/sembast.dart';
import 'package:url_shorten/core/sembast_kv_store.dart';
import 'package:url_shorten/data/apis/shortener_apis.dart';
import 'package:url_shorten/data/repositories/url_shortening_repositories.dart';
import 'package:url_shorten/presentation/blocs/url_shorten_bloc.dart';
import 'package:url_shorten/presentation/blocs/main_navigation_bar_bloc.dart';
import 'package:url_shorten/presentation/pages/pages.dart';
import 'package:uuid/uuid.dart';

import 'navigation_page.dart';

final Uuid uuid = Uuid();
final GetIt services = GetIt.instance;
final mainPageNavigatorState = GlobalKey<NavigatorState>();

const pages = [
  NavigationPage(Icons.link, 'Shorten', shortenUrlsPage),
  NavigationPage(Icons.access_time, 'Past URLs', pastUrlsPage)
];

Future<void> setupServices() async {
  print('setting up');
  final sembast = Sembast();
  await sembast.initialize();
  final kvStore = SembastKvStore(sembast.database);

  services.registerSingleton(UrlShorteningRepository(kvStore, [HideUrlApi(), IsGdApi()]));

  services.registerLazySingleton(() => MainNavigationBarBloc(pages: pages, mainPageNavigatorState: mainPageNavigatorState));
  services.registerLazySingleton(() => UrlShortenBloc());
}

// show generic SnackBar
void showSnackBar(
    {String text,
    Widget child,
    BuildContext context,
    Color color = Colors.blue,
    bool replaceExisting = true,
    ScaffoldState scaffold}) {
  if (scaffold == null) {
    if (context == null) throw Exception('Can not access context');
    scaffold = Scaffold.of(context);

    if (scaffold == null) throw Exception('Can not access scaffold');
  }

  if (replaceExisting) scaffold.removeCurrentSnackBar();

  scaffold.showSnackBar(
    SnackBar(
      content: child ?? Text(text ?? ''),
      backgroundColor: color,
    ),
  );
}
