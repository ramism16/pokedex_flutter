import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void setNavBarsSplashColors(bool set){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: set ? Color(0xff3558CD) : Colors.white,
      statusBarBrightness: set ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: set ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: set ? Color(0xff3558CD) : Colors.white,
      systemNavigationBarIconBrightness: set ? Brightness.light : Brightness.dark,
    ));
  }

  @override
  void initState() {
    setNavBarsSplashColors(true);
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
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
