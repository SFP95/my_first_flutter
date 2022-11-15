import 'package:flutter/material.dart';

class SendMessageBubble extends StatelessWidget{

  final String Mensaje;

  const SendMessageBubble({Key? key, required this.Mensaje}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageTextGroup= Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.purple[700],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: Text(
                    Mensaje,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14
                    ),
                  ),
                ),
            )
          ],
        ));
    return Padding(
        padding: EdgeInsets.only(right: 8.0, left: 60 ,top: 5,bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(height: 30),
            messageTextGroup,
          ],
        ),
    );
  }
}