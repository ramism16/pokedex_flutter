import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokedex_flutter/models/pokemon.dart';
import 'package:pokedex_flutter/pages/log_in.dart';
import 'package:pokedex_flutter/pages/sign_up.dart';
import 'pages/pokemon_details.dart';
import 'pages/home.dart';
import 'pages/splash_screen_page.dart';
import 'navigation_error_screen.dart';

class RouteGenerator {
  static ValueNotifier currentRoute = ValueNotifier("");
  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute.value = settings.name;
    switch (settings.name) {
      case "/SplashScreen":
        return PageTransition(child: SplashScreenPage(), type: PageTransitionType.fade);
      case "/Home":
        return PageTransition(child: HomePage(), type: PageTransitionType.fade);
      case "/Details":
        return PageTransition(child: DetailsPage(settings.arguments as Pokemon), type: PageTransitionType.fade);
      case '/Signup':
        return PageTransition(child: SignUpUserPage(), type: PageTransitionType.fade);
       case '/Login':
         return PageTransition(child: LogInUserPage(), type: PageTransitionType.fade);
      default:
        return PageTransition(child: NavigationErrorPage(settings.name), type: PageTransitionType.fade);
    }
  }
}
