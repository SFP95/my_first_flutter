import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/custom_views/RFInputText.dart';

import '../fb_proyects/Perfil.dart';

class OnBoardingView extends StatelessWidget{

  OnBoardingView({Key?key}):super(key: key);

  final myController = TextEditingController();

  final RFInputText inputNombre=RFInputText(
    titulo: 'Nombre:',
    ayuda: 'Escriba su Nombre',);
  final RFInputText inputPais=RFInputText(
    titulo: 'Pais:',
    ayuda: 'Escriba su Pais',);
  final RFInputText inputCiudad=RFInputText(
    titulo: 'Ciudad:',
    ayuda: 'Escriba su Ciudad',);
  final RFInputText inputEdad=RFInputText(
    titulo: 'Edad:',
    ayuda: 'Escriba su Edad',);

 FirebaseFirestore db=FirebaseFirestore.instance;

  void accepPressed(String nombre, String ciudad, String pais, int edad,BuildContext context) async{

    Perfil perfil= Perfil(name: nombre, country: pais, city: ciudad,edad: edad);


    await db.collection("perfiles").doc(FirebaseAuth.instance.currentUser?.uid).set(perfil.toFirestore())
        .onError((e, _) => print("Error writing document: $e"));

    Navigator.of(context).pop('/home');
    }

    void checkExistingProfile(BuildContext context) async{
      String? idUser=FirebaseAuth.instance.currentUser?.uid;
      final docRef=db.collection("perfiles").doc(idUser);

      DocumentSnapshot docsnap=await docRef.get();

      if(docsnap.exists){
        Navigator.of(context).pop('/home');
      }
    }

  @override
  Widget build(BuildContext context) {
  //inputEdad.setInitialValue("VALOR INICIAL NOMBRE");

    TextField txtMensaje=TextField(controller: myController, readOnly: true, style: TextStyle(color: Colors.red,fontSize: 16),);

    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputNombre,
            inputPais,
            inputCiudad,
            inputEdad,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:(){
                    accepPressed(inputNombre.getText(),inputPais.getText(),inputCiudad.getText(),int.parse(inputEdad.getText()),context);
                  },

                  child: Text("Aceptar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[900],
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).popAndPushNamed('/loginView');
                  },
                  // Respond to button press

                  child: Text("Cancelar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[900],
                  ),
                ),
              ],
            )],
        ),
      ),

    );
  }
  }


