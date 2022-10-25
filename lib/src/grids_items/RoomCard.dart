import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fb_proyects/Room.dart';

class RoomCard extends StatelessWidget{

  final String imgURL;
  final String name;
  final Function(int index) onShorClick;
  final int index;

  const RoomCard({Key? key, required this.imgURL, required this.name, required this.onShorClick, required this.index}):super (key:key);


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      child: InkWell(
        onTap:() {
          onShorClick(index);
          },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Image.network(imgURL),
              Text(name),
            ]
        ),
      )
      );



  }
}