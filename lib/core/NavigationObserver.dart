import 'package:flutter/material.dart';

class NavigationObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
  }

  // Ako je potrebno da sačekaš završetak animacije
  Future<void> waitForNavigator() async {
    await Future.delayed(Duration(milliseconds: 500)); // Povećaj vremenski interval ako je potrebno
  }
}
