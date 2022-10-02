import 'package:flutter/material.dart';

class RFInputText extends StatelessWidget{

  final String titulo;
  final String ayuda;
  final bool blIsPsswd;
  final TextEditingController myController = TextEditingController();

  RFInputText({Key? key,  this.titulo="",  this.blIsPsswd=false,  this.ayuda=""}): super (key:key);

  String getText(){
    return myController.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      cursorColor: Colors.purpleAccent,
      maxLength: 80,
      decoration: const InputDecoration(
        icon: Icon(Icons.account_circle_outlined),
        labelText: titulo, //EMAIL
        labelStyle: TextStyle(
          color: Color(0xFF6200EE),
        ),
        helperText: ayuda, //Ej: MrPotato@micorreo.com
        suffixIcon: Icon(
          Icons.abc,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6200EE)),
        ),
      ),
    );
  }

}