

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart ';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailCtr = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailCtr.dispose();
  }

Future passwordReset() async {
  try {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailCtr.text.trim());
   showDialog(
    context: context,
    builder: (context){
      return AlertDialog( 
        content: Text("Password reset link sent!"),
      );
    }
  );
}on FirebaseAuthException catch (e) {
  print(e);
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog( 
        content: Text(e.message.toString()),
      );
    }
  );
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LIGHT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
            Text("CHAT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple[300],)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("Enter your Email and we will send you a password reset link",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20
              ),),
            ),
            SizedBox(
              height: 10,
            ),

            
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: emailCtr,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: InputBorder.none,
                    hintText: 'Email',
                    fillColor: Colors.grey,
                    filled: true
                  ),
                ),
              ),
          
SizedBox(
  height: 10,
),
        MaterialButton(onPressed: () {
          passwordReset();
        },
        child: Text("Reset Password"),
          color: Colors.deepPurple,
          )
          ],
        ),
      ),
    );
  }
}