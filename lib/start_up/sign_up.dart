import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w_news/start_up/login_screen.dart';

class SignUp extends StatefulWidget {
final VoidCallback showLogInPage;
  const SignUp({Key? key, required this.showLogInPage}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   //emailCtr
  TextEditingController emailCtr = TextEditingController();
   TextEditingController passwordCtr = TextEditingController();
   final confirmPasswordCtr = TextEditingController();
   final _firstNameCtr = TextEditingController();
   final _lastNameCtr = TextEditingController();
FirebaseFirestore _firestore = FirebaseFirestore.instance;
User? user = FirebaseAuth.instance.currentUser;
   Future<User?> signUp () async{
    if(passwordConfirmed()){

      showDialog(context: context,
     builder:(context){
       return Center(child: CircularProgressIndicator(
         color: Colors.deepPurpleAccent,
       ));
     }
     );

     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailCtr.text.trim(), password: passwordCtr.text.trim());
User? user = FirebaseAuth.instance.currentUser;
     user!.updateProfile(displayName: _firstNameCtr.text );

      _firestore.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).set({
      "first name": _firstNameCtr.text.trim(),
      "last name": _lastNameCtr.text.trim(),
      "email": emailCtr.text.trim(),
      "status": "Unavailable",
      "uid": FirebaseAuth.instance.currentUser!.uid, 
     });
    }
     
  Navigator.pop(context);


   }

   bool passwordConfirmed(){
    if(passwordCtr.text.trim() == confirmPasswordCtr.text.trim()) {
     return true; 
    }else{
      return false;
    }
   }

   @override
  void dispose() {
    emailCtr.dispose();
    passwordCtr.dispose();
    confirmPasswordCtr.dispose();
    
    // TODO: implement dispose
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
      Text('Hello There',
      style: GoogleFonts.bebasNeue(
        fontSize: 52,
      ),),

      SizedBox(
        height: 10,
      ),

      Text('Register Below',
      style: TextStyle(
        
        fontSize: 20,
      ),),
      
      SizedBox(
        height: 50,
      ),
      //First Name
      Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _firstNameCtr,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                     borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: InputBorder.none,
                  hintText: 'First Name',
                  fillColor: Colors.grey,
                  filled: true
                ),
              ),
            
      ),

      SizedBox(
        height:10 ,
      ),

      //Last name
      Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: _lastNameCtr,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                     borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: InputBorder.none,
                  hintText: 'Last Name',
                  fillColor: Colors.grey,
                  filled: true
                ),
              ),
            
      ),

      SizedBox(
        height:10 ,
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
      //confirm password 

       Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: confirmPasswordCtr,
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
                  hintText: 'Confirm Password',
                  fillColor: Colors.grey,
                  filled: true
                ),
              ),
            
      ),
       SizedBox(
        height:10 ,
      ),
                //sign in
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: GestureDetector(
          onTap: signUp ,
          child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius:  BorderRadius.circular(12),
              ),
              
              child: Center(child: Text("Sign Up",
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
                    Text('Already a member?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    GestureDetector(
                      onTap: widget.showLogInPage,
                      child: Text(" Sign In",
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

