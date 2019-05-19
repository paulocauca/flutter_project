import 'package:apportho/pages/auth_provider.dart';
import 'package:flutter/material.dart';
import 'login_signup_page.dart';
import 'auth.dart';
import 'clinica_page.dart';

class RootPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final BaseAuth auth = AuthProvider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final bool isLoggedIn = snapshot.hasData;
          return isLoggedIn ? ClinicaPage() : LoginPage();
        }
        return _buildWaitingScreen();
      } 
    );
  }
  
  Widget _buildWaitingScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }


}
