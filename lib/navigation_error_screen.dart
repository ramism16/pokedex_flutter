import 'package:flutter/material.dart';

class NavigationErrorPage extends StatelessWidget {
  final String? routeName;
  NavigationErrorPage(this.routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: Center(child: Text("Navigation error: routeName = $routeName"),)
    );
  }
}
