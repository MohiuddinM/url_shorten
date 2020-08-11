import 'package:flutter/material.dart';
import 'package:url_shorten/core/services.dart';
import 'package:url_shorten/presentation/blocs/main_navigation_bar_bloc.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({Key key}) : super(key: key);

  Widget buildBottomNavigationBar() {
    final bloc = services<MainNavigationBarBloc>();

    return StreamBuilder<int>(
      initialData: 0,
      stream: bloc.index,
      builder: (context, snapshot) {
        return BottomNavigationBar(
          onTap: bloc.navigateTo,
          currentIndex: snapshot?.data,
          items: bloc.pages
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  title: Text(item.name),
                ),
              )
              .toList(growable: false),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBottomNavigationBar();
  }
}
