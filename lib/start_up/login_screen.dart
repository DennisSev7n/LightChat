import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w_news/start_up/forgot_password.dart';
import 'package:w_news/start_up/sign_up.dart';

class Login extends StatefulWidget {
    final VoidCallback showSignUpPage;
  const Login({Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  //emailCtr
  TextEditingController emailCtr = TextEditingController();
   TextEditingController passwordCtr = TextEditingController();

   //signIn 
   Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailCtr.text.trim(), password: passwordCtr.text.trim());
   }

@override
  void dispose() {
    // TODO: implement dispose
    emailCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                //Hello  again
      Text('Hello Once More',
      style: GoogleFonts.bebasNeue(
        fontSize: 52,
      ),),

      SizedBox(
        height: 10,
      ),

      Text('Welcome Back! we missed you',
      style: TextStyle(
        
        fontSize: 20,
      ),),
      
      SizedBox(
        height: 50,
      ),
      
                //email textfield
      Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: emailCtr,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
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
        height:10 ,
      ),
                //password textfield
      
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                
                controller: passwordCtr,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                     borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: InputBorder.none,
                  hintText: 'Password',
                  fillColor: Colors.grey,
                  filled: true
                ),
              ),
          
      ),
      SizedBox(
        height:10 ,
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ForgotPassword();
                },));
              },
              child: Text("Forgot Password ?",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ],
        ),
      ), 

       SizedBox(
        height:10 ,
      ),
                //sign in
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: GestureDetector(
          onTap: signIn ,
          child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius:  BorderRadius.circular(12),
              ),
              
              child: Center(child: Text("Sign In",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,

              ),
              )),
          ),
        ),
      ),
       SizedBox(
        height:25 ,
      ),
                //not a member

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    GestureDetector(
                      onTap: widget.showSignUpPage,
                      child: Text(" Register now",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}