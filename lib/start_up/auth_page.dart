import 'package:flutter/material.dart';
import 'package:w_news/start_up/login_screen.dart';
import 'package:w_news/start_up/sign_up.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show the login pagfe
  bool showLogInPage = true;
  void toggleScreens(){
setState(() {
  showLogInPage = !showLogInPage;
});
  }
  @override
  Widget build(BuildContext context) {
    if(showLogInPage){
      return Login(showSignUpPage: toggleScreens );
    }else{
      return SignUp(showLogInPage: toggleScreens );
    }
  }
}