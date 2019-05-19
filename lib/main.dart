import 'package:apportho/pages/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:apportho/pages/auth.dart';
import 'package:apportho/pages/root_page.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AuthProvider(
      auth: Auth(),
          child: new MaterialApp(
          debugShowCheckedModeBanner : false,
            title : 'App Ortho',
            theme: new ThemeData(
            primarySwatch: Colors.blue
        ),
            home: new RootPage()
      ),
    );

  }
}