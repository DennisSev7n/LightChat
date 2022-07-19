import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:w_news/home.dart';
import 'package:w_news/start_up/auth_page.dart';
import 'package:w_news/start_up/intro_page1.dart';
import 'package:w_news/start_up/onBoard_screen.dart';

class MainPageLog extends StatefulWidget {
  const MainPageLog({Key? key}) : super(key: key);

  @override
  State<MainPageLog> createState() => _MainPageLogState();
}

class _MainPageLogState extends State<MainPageLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return HommePage();
          }else{
            return AuthPage();
          }
        } ,
       
        ),
    );
  }
}