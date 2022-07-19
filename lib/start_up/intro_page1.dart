import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:w_news/start_up/auth_page.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return AuthPage();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
color: Colors.transparent,
  child:   SafeArea(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Row(
            
              mainAxisAlignment: MainAxisAlignment.center,
            
              children: [
            
                    Text("LIGHT", style: TextStyle(
            
                      fontWeight: FontWeight.bold,
            
                      color: Colors.white,
                      fontSize: 30
            
                    ),),
            
            
            
                     Text("CHAT", style: TextStyle(
            
                      fontWeight: FontWeight.bold,
            
                      color: Colors.deepPurple,
                      fontSize: 30
            
                    ),),
            
              ],
            
            ),
          ),
          SizedBox(
            height: 10,
          ),
  
        CupertinoActivityIndicator(
          radius: 20,
        )
        ],
      ),
    ),
  ),
  
);
  }
}