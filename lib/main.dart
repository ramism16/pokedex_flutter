import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/shared_preferences_controller.dart';
import 'settings/constants.dart' as constants;
import 'package:firebase_core/firebase_core.dart';
import 'route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(name: "Pokedex Flutter",
    options: FirebaseOptions(
      apiKey: "AIzaSyALT8mRcHWwSGg8LHTlD7cBCoN8WJjVItQ",
      appId: "1:29920040328:android:709324139e93d96923d63d",
      messagingSenderId: "29920040328",
      projectId: "pokedex-bloc")
  );
  runApp(PokedexApp());
}

class PokedexApp extends StatefulWidget {
  @override
  State<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends State<PokedexApp> with WidgetsBindingObserver {

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    // Persist user state (containing favourites) using singleton model to cache
    if (state == AppLifecycleState.resumed)
      await SharedPreferencesController.readState();
    else
      await SharedPreferencesController.saveState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      navigatorKey: constants.navigatorKey,
      scaffoldMessengerKey: constants.scaffoldMessengerKey,
      initialRoute: '/SplashScreen',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffE8E8E8),
        primaryColor: Color(0xff3558CD),
        textTheme: TextTheme(
          //POKEMON NAME (DETAILS SCREEN)
          headline1: GoogleFonts.notoSans(
              color: Color(0xff161A33), fontSize: 32,
              fontWeight: FontWeight.w700),
          //APPBAR TITLE
          headline2: GoogleFonts.notoSans(
            color: Color(0xff161A33), fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          //SELECTED TAB TEXT
          headline3: GoogleFonts.notoSans(
              color: Color(0xff161A33), fontSize: 16,
              fontWeight: FontWeight.w500),
          //UNSELECTED TAB TEXT
          headline4: GoogleFonts.notoSans(
              color: Color(0xff6B6B6B), fontSize: 16,
              fontWeight: FontWeight.w400),
          //POKEMON NAME (GRID CARDS) & DETAILS SCREEN TEXT
          headline5: GoogleFonts.notoSans(
              color: Colors.black, fontSize: 14,
              fontWeight: FontWeight.w600),
          //GRID CARDS OTHER TEXT
          headline6: GoogleFonts.notoSans(
              color: Color(0xff6B6B6B), fontSize: 12,
              fontWeight: FontWeight.w400),
          //DETAILS SCREEN LIST SUBHEADINGS
          bodyText1: GoogleFonts.notoSans(
              color: Color(0xff6B6B6B), fontSize: 14,
              fontWeight: FontWeight.w400),
          //DETAILS SCREEN HEADER ROW SUBHEADINGS
          bodyText2: GoogleFonts.notoSans(
              color: Color(0xff6B6B6B), fontSize: 12,
              fontWeight: FontWeight.w500)
        )
      ),
    );
  }
}
