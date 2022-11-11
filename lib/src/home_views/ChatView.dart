import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../custom_views/RFInputText.dart';
import '../fb_proyects/FBText.dart';
import '../list_items/ChatItem.dart';
import '../singleton/DataHolder.dart';

class ChatView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChatViewState();
  }

}

class _ChatViewState extends State<ChatView>{

  FirebaseFirestore db = FirebaseFirestore.instance;
  List<FBText> chatTexts = [];
  RFInputText inputMsg=RFInputText();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //print("DEBUG: "+DataHolder().selectedChatRoom.name!);
    descargarTextos();
  }

  void descargarTextos() async{

    String path=DataHolder().sCOLLECTION_ROOMS_NAME+"/"+
        DataHolder().selectedChatRoom.uid+
        "/"+DataHolder().sCOLLECTION_TEXTS_NAME;

    final docRef = db.collection(path).
    withConverter(
        fromFirestore: FBText.fromFirestore,
        toFirestore: (FBText fbtext, _) => fbtext.toFirestore());

    docRef.snapshots().listen(
          (event) => {
        setState(() {
          chatTexts.clear();
          for(int i=0;i<event.docs.length;i++){
            chatTexts.add(event.docs[i].data());
          }
          chatTexts.sort(compareChatText);
        })
      },
      onError: (error) => print("Listen failed: $error"),
      );
    }
  int compareChatText(FBText a,FBText b){
    int? res=a.time?.compareTo(b.time!);
    //print("COMPARATOR A: "+a.time.toString()+"  B: "+b.time.toString()+" = "+res.toString());
    return res!;
    //return a.time?.compareTo(b.time!);

    //return 0;
  }

  void sendPressed()async {
    String path=DataHolder().sCOLLECTION_ROOMS_NAME+"/"+
        DataHolder().selectedChatRoom.uid+
        "/"+DataHolder().sCOLLECTION_TEXTS_NAME;

    final docRef = db.collection(path);

    FBText texto=FBText(text:inputMsg.getText(),
        author: DataHolder().selectedChatRoom.uid ,time: Timestamp.now());
              // FirebaseAuth.instance.currentUser?.uid
    await docRef.add(texto.toFirestore());

    //descargarTextos();

  }

  void listItemShortClicked(int index){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text(DataHolder().selectedChatRoom.name!),
      ),
      //backgroundColor: Colors.orangeAccent,
      body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.purple[200],
                height: 400,
                child: ListView.builder(
                  //padding: const EdgeInsets.all(8),
                  itemCount: chatTexts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatItem(texto: chatTexts[index].text!,
                      onShortClick: listItemShortClicked,
                      index: index,
                      author: chatTexts[index].author!,);
                  },
                  /*separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                    //return RFInputText2(sTitulo: "DIVISOR DEL: "+entries[index],);
                  },*/
                ),
              ),
              inputMsg,
              ElevatedButton(
                style:ElevatedButton.styleFrom(
                  backgroundColor: Colors.white54,
                ),
                onPressed: sendPressed,
                child: Text("Enviar",
                    style: TextStyle(
                        color:Colors.deepPurple,
                        fontSize: 30)),
              )

            ],
          )

      ),
    );
  }
  }