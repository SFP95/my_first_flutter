import 'package:flutter/material.dart';

class nameBox extends StatelessWidget{
  final String Bxnombre;

  const nameBox({Key? key, required this.Bxnombre}):super (key:key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.deepPurple),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(Bxnombre),
        ),
    );
  }

}