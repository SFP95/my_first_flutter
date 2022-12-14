import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  final ImagePicker _picker = ImagePicker();
  late File imageFile;
  bool blImageLoaded=false;
  double dListHeightPorcentage=0.8;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //print("DEBUG: "+DataHolder().selectedChatRoom.name!);
    descargarTextos();
  }

  void descargarTextos() async{
    // "EDeAL8r0mBn2jHHEo9tt"+

    // String path=DataHolder().sCOLLECTION_ROOMS_NAME+"/"+
    //         DataHolder().selectedChatRoom.uid+
    //         "/"+DataHolder().sCOLLECTION_TEXTS_NAME;

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
         // chatTexts.clear();
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

  void sendPressed(String sNuevoTexto)async {
    String path=DataHolder().sCOLLECTION_ROOMS_NAME+"/"+
        DataHolder().selectedChatRoom.uid+
        "/"+DataHolder().sCOLLECTION_TEXTS_NAME;

    final docRef = db.collection(path);

    FBText texto=FBText(text:sNuevoTexto,
        idUser: FirebaseAuth.instance.currentUser?.uid,
        time: Timestamp.now(),
        );

    await docRef.add(texto.toFirestore());

    setState(() {
      blImageLoaded=false;
      dListHeightPorcentage=0.8;
    });
    //descargarTextos();

  }

  void listItemShortClicked(int index){

  }
  void selectImage() async{
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    //final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        blImageLoaded=true;
        dListHeightPorcentage=0.5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(

     backgroundColor: Colors.purple[100],
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
                color: Colors.purple[100],
                height: 400,
                child: ListView.builder(
                  //padding: const EdgeInsets.all(8),
                  itemCount: chatTexts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatItem(texto: chatTexts[index].text!,
                      onShortClick: listItemShortClicked,
                      index: index,
                      author: chatTexts[index].idUser,);
                  },
                  /*separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                    //return RFInputText2(sTitulo: "DIVISOR DEL: "+entries[index],);
                  },*/
                ),
              ),

              if(blImageLoaded)Container(height: DataHolder().platformAdmin.getScreenHeight(context)*0.3,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.fitHeight,
                ),
              ),

              MessageBar(
                onSend: (texto) => { sendPressed(texto)},
                actions: [

                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 8),
                    child: InkWell(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.purple[800],
                        size: DataHolder().platformAdmin.getScreenWidth(context)*0.065,
                      ),
                      onTap: () {
                        selectImage();

                      },
                    ),
                  ),
                ],
              ),
              /*Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: inputMsg),
                  //Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                  Flexible(child:OutlinedButton(
                    onPressed: sendPressed,
                    child: Text("Send"),
                  ))
                ],
              )*/


            ],
          )

      ),
    );
  }
}