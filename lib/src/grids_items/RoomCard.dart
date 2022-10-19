import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fb_proyects/Room.dart';

class RoomCard extends StatelessWidget{

  final String imgURL;
  final String name;

  const RoomCard({Key? key}):super (key:key);


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Image.network(imgURL),
          Text(name),
    ]
      ),
    );
  }
}