import 'package:flutter/material.dart';

import '../presentation/pages/pages.dart';

class Navigator {
  final _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<Object> pushNamed(String routeName, {Map<String, Object> args, bool replace = false}) async {
    return replace ? _navigatorKey.currentState.pushReplacementNamed(routeName, arguments: args) : _navigatorKey.currentState.pushNamed(routeName, arguments: args);
  }

  Future<bool> goBack<T>({T result}) async {
    return _navigatorKey.currentState.maybePop(result);
  }
}

extension StringExtension on String {
  Future<Object> push({Map<String, Object> args, bool replace = false}) async {
    return navigator.pushNamed(this, args: args, replace: replace);
  }

  void pushDialog({Object arg, Map<String, Object> args, BuildContext context}) {
    showDialog(
      barrierDismissible: true,
      context: context ?? navigator.navigatorKey.currentContext,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Material(
            borderRadius: BorderRadius.circular(15),
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 500,
              color: Colors.black,
              child: getRouteWidget(this, args),
            ),
          ),
        );
      },
    );
  }
}

final navigator = Navigator();
