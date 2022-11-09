import 'package:flutter/material.dart';

import '../custom_views/chat_bubbles/send_menssage_bubble.dart';

class ChatItem extends StatelessWidget{

  final String texto;
  final Function(int index) onShortClick;
  final int index;

  const ChatItem({Key? key, this.texto="mensaje", required this.onShortClick,
    required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SendMessageBubble(Mensaje: texto);
      /*Container(
      height: 25,
      child: Center(
        child: Text(texto),
      ),
    );*/
  }

}