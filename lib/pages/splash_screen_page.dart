import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void setNavBarsSplashColors(bool set) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: set ? Color(0xff3558CD) : Colors.transparent,
      statusBarBrightness: set ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: set ? Brightness.light : Brightness.dark,
      systemStatusBarContrastEnforced: true,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarColor: set ? Color(0xff3558CD) : Colors.white,
      systemNavigationBarIconBrightness:
          set ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  void initState() {
    setNavBarsSplashColors(true);
    Timer(Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser != null)
        Navigator.of(context).pushReplacementNamed('/Home');
      else
        Navigator.of(context).pushReplacementNamed("/Login");
      setNavBarsSplashColors(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset('assets/pokeball.png', height: 75, width: 75,),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("POKEMON",
                  style: GoogleFonts.notoSans(
                      color: Colors.white, fontSize: 16,
                      fontWeight: FontWeight.w400, letterSpacing: 5),
                ),
                Text("Pokedex",
                  style: GoogleFonts.notoSans(
                      color: Colors.white, fontSize: 48,
                      fontWeight: FontWeight.w700),
                ),
              ],
            )
        ])),
      ),
    );
  }
}
