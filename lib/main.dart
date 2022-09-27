import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/user.dart';
import 'settings/constants.dart' as constants;
import 'route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      await User.readState();
    else
      await User.saveState();
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
