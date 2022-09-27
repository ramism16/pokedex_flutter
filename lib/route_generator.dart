import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex_flutter/Pages/pokemon_details.dart';
import 'Pages/splash_screen_page.dart';
import 'navigation_error_screen.dart';

class RouteGenerator {
  static ValueNotifier currentRoute = ValueNotifier("");
  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute.value = settings.name;
    switch (settings.name) {
      case "/SplashScreen":
        return PageTransition(
            child: SplashScreenPage(), type: PageTransitionType.fade);
      case "/Details":
        return PageTransition(
            child: DetailsPage(), type: PageTransitionType.fade);
      default:
        return PageTransition(
            child: NavigationErrorPage(settings.name),
            type: PageTransitionType.fade);
    }
  }
}
