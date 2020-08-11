import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_shorten/core/navigation_page.dart';

class MainNavigationBarBloc {
  final List<NavigationPage> pages;
  final GlobalKey<NavigatorState> mainPageNavigatorState;

  final _pageIndex = BehaviorSubject<int>.seeded(0);

  MainNavigationBarBloc({this.pages, @required this.mainPageNavigatorState});

  Stream<int> get index => _pageIndex.stream;

  int get currentIndex => _pageIndex.value;

  void refresh() {
    _pageIndex.add(_pageIndex.value);
  }

  void navigateTo(int index) {
    if (index != null && index >= 0 && index != _pageIndex.value) {
      mainPageNavigatorState.currentState.pushNamed(pages[index].path);
      _pageIndex.add(index);
    }
  }
}
