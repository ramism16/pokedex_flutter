import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void setNavBarsSplashColors(bool set) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: set ? Color(0xff3558CD) : Colors.white,
      statusBarBrightness: set ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: set ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: set ? Color(0xff3558CD) : Colors.white,
      systemNavigationBarIconBrightness:
          set ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  void initState() {
    setNavBarsSplashColors(true);
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/Details');
      setNavBarsSplashColors(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3558CD),
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/icons/pokeball.png',
            //   height: 75,
            //   width: 75,
            // ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "POKEMON",
                  style: GoogleFonts.notoSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3),
                ),
                Text(
                  "Pokedex",
                  style: GoogleFonts.notoSans(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w700),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
