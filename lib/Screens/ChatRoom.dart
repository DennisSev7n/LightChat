import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatelessWidget {
   ChatRoom({Key? key,  required this.userMap, required this.chatRoomId}) : super(key: key);

   final Map<String, dynamic> userMap;
   final String chatRoomId;

  final TextEditingController _message = TextEditingController();
  File? imageFile;

Future getImage() async{
  ImagePicker _picker = ImagePicker();

  await _picker.pickImage(source: ImageSource.gallery).then((XFile){
    if(XFile != null){
       imageFile = File(XFile.path);

       upLoadImage();
    }
  });
}

Future upLoadImage() async{

  String fileName = Uuid().v1();
  int status =1;
  await FirebaseFirestore.instance.collection('chatroom')
    .doc(chatRoomId)
    .collection('chats').doc(fileName).set(({
      "sendby": FirebaseAuth.instance.currentUser!.displayName,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    }));
  var ref = FirebaseStorage.instance.ref().child("images").child("$fileName.jpg");

  await ref.putFile(imageFile!).catchError((error) async{
    await FirebaseFirestore.instance.collection('chatroom')
    .doc(chatRoomId)
    .collection('chats')
    .doc(fileName)
    .delete();

    status = 0;
  });

  if(status ==1 ){
     var imageUrl = await ref.getDownloadURL();
    await FirebaseFirestore.instance.collection('chatroom')
    .doc(chatRoomId)
    .collection('chats')
    .doc(fileName)
    .update({
      "message": imageUrl
    });
    print(imageUrl);
  }

  

}

 
  
  

  void onSendMessage() async{
    if(_message.text.isNotEmpty){
      Map<String, dynamic> messages ={
      "sendby": FirebaseAuth.instance.currentUser!.displayName,
      "message": _message.text,
      "type": "text",
      "time": FieldValue.serverTimestamp(),
    };
_message.clear();
    await FirebaseFirestore.instance.collection('chatroom')
    .doc(chatRoomId)
    .collection('chats')
    .add(messages);


    }else{
      print("Enter some text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size =  MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
       
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

             StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('user').doc(userMap['uid']).snapshots(),
              builder: ((context, snapshot) {
               if(snapshot.data != null){
                return Container(
                  child: Row(
                    children: [
                       Icon(Icons.person),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                         
                          Text(userMap['first name']) ,
                          Text(
                            userMap['status'],
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ) ,
                        ],
                      ),
                    ],
                  )
                );


               }else{
                return Container();

               }
             }))
              
            ],
          ),
        ),

      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height:  MediaQuery.of(context).size.height/1.25,
              width:  MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('chatroom').doc(chatRoomId).collection('chats')
                .orderBy('time', descending: false)
                .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.data != null){
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic>? map = snapshot.data!.docs[index].data() as Map<String, dynamic>?;
                        return   messages(size, map!);
                      }
                    );
                  }else{
                    return Container(

                    );
                  }
                }
                ),
            ),
             Container(
          height: MediaQuery.of(context).size.height/10,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,

          child: Container(
            height: MediaQuery.of(context).size.height/12,
            width: MediaQuery.of(context).size.width/1.1,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height/17,
            width: MediaQuery.of(context).size.width/1.3,

            child: TextField(
    //             keyboardType: TextInputType.multiline,
    //     textInputAction: TextInputAction.newline,
    //       autofocus: true,
    //  maxLines: null,
              controller: _message,
              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: getImage, 
                icon: Icon(Icons.photo)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                        
                      ),
                      hintText: "Send Message",
                      
                      
              ),
            ),

                ),

                IconButton(onPressed: onSendMessage, icon: Icon(Icons.send), focusColor: Colors.deepPurple, hoverColor: Colors.deepPurpleAccent,
                 )
              ],
            ),
          ),
        ),
          ],
        ),
      )
    );

      
      
  }
  Widget messages (Size size, Map<String, dynamic> map){
    return map['type'] =='text'? Container(
      width:  size.width,
      alignment: map['sendby'] == FirebaseAuth.instance.currentUser!.displayName? Alignment.centerRight:
       Alignment.centerLeft,

       child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: map['sendby'] == FirebaseAuth.instance.currentUser!.displayName? Colors.deepPurple:
          Colors.grey
        ),

        child: Text(map['message'], style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),),
       ),
      

    ) :map['type'] =='img'? Container(
      height: size.height/2.5,
      width: size.width,
      alignment: map['sendby'] ==  FirebaseAuth.instance.currentUser!.displayName?
      Alignment.centerRight
      : Alignment.centerLeft,

      child: Container(
        height: size.height /2.5,
        width: size.width/ 2,
        alignment: Alignment.center,
        child: map['message'] != ""? Image.network(map['message'])
        : CircularProgressIndicator() ,
      ),
    ):Container(

    );
  }
}