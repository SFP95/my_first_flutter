import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom_views/chat_bubbles/received_message_bubble.dart';
import '../custom_views/chat_bubbles/send_menssage_bubble.dart';

class ChatItem extends StatelessWidget{

  final String texto;
  final Function(int index) onShortClick;
  final int index;
  final String? author;

  const ChatItem({Key? key, this.texto="mensaje", required this.onShortClick,
    required this.index, required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
              //DataHolder().perfil.uid
    if(author==FirebaseAuth.instance.currentUser?.uid){
      return BubbleSpecialThree(
        text: texto,
        color: Color(0xFF43F31B),
        tail: true,
        textStyle: TextStyle(
          color: Colors.purple[300],
          fontSize: 16
        ),
    );
      // return  ReceivedMessageBubble(Mensaje: texto);
    }else{
      //return ReceivedMessageBubble(sMessage: texto);
      return BubbleSpecialThree(
        text: texto,
        color: Color(0xFFE8E8EE),
        tail: true,
        isSender: false,
      );
    }

      /*Container(
      height: 25,
      child: Center(
        child: Text(texto),
      ),
    );*/
  }

}