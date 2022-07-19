import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:w_news/Screens/ChatRoom.dart';

class HommePage extends StatefulWidget {
  const HommePage({Key? key}) : super(key: key);

  @override
  State<HommePage> createState() => _HommePageState();
}

class _HommePageState extends State<HommePage> with WidgetsBindingObserver {

  

  Map<String, dynamic> ?userMap;

FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status)async{

    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({"status": status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if (state == AppLifecycleState.resumed){
      //online
      setStatus("Online");

    }else{
      //offline
      setStatus("Offline");
    }
  }

  String chatRoomId (String user1, String user2){
    if(user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]){
      return "$user1$user2";
    }else{
      return "$user2$user1";
    }
  }

  void onSearch () async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore.collection('users').where('email', isEqualTo:  _search.text.trim()).get().then((value){
 

 setState(() {
   userMap = value.docs[0].data();

   isLoading = false;
 });
    });

    print(userMap);
  }
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        elevation: 0.0,
        backgroundColor: Colors.transparent,
       
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Text("LIGHT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,)),
              Text("CHAT", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple[300],)),

              
            ],
          ),
        ),

         centerTitle: true,
         actions: [
                     GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.logout, color: Colors.deepPurple,),
            ),
          )
         ],
        
        
      ),

      body: isLoading? Center(
        child: Container(
          height: MediaQuery.of(context).size.height/20 ,
          width: MediaQuery.of(context).size.height/20,

          child: CircularProgressIndicator(
            color: Colors.deepPurpleAccent,
          ),
        ),
      )
      : Column(
        children: [

          SizedBox(
            height: MediaQuery.of(context).size.height /20,
          ),

          Container(
            height: MediaQuery.of(context).size.height/ 14,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height/14,
              width: MediaQuery.of(context).size.width/ 1.2,

              child:  TextField(
              controller: _search,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.deepPurple,),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
SizedBox(
  height:MediaQuery.of(context).size.height/ 50,
),

ElevatedButton.icon(
  
  onPressed: onSearch,
   icon: Icon(Icons.search_sharp), label: Text("Search"),
style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepPurple))
),


SizedBox(
  height: MediaQuery.of(context).size.height/10 ,
),
userMap != null ? ListTile(

onTap:  (){
  String roomId = chatRoomId(_auth.currentUser!.displayName!, userMap?['first name']);
   Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatRoom(
    chatRoomId: roomId ,
    userMap: userMap!,
   ) ));
},
leading: Icon(Icons.account_box, color: Colors.deepPurple, size: 50,),
  title: Text(userMap?['first name' ],
  style: TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.w500
  ),),
  subtitle: Text(userMap?['email']),
  trailing: Icon(Icons.chat, color: Colors.deepPurpleAccent,),
): Container()
          

        ],
      ),
    );

  
  }

  Widget chatTile( Size size) {
    return Container(
      height: MediaQuery.of(context).size.height/12,
      width: MediaQuery.of(context).size.width/1.2,

      child: Row(children: [

      ]),
    );
  }
}