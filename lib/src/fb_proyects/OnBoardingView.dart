import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/custom_views/RFInputText.dart';

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

  void accepPressed(String nombre, String ciudad, String pais, int edad) async{
    final datosPerfil = <String, dynamic>{
      "name": nombre,
      "country": pais,
      "city": ciudad,
      "edad": edad
    };

    db.collection("perfiles").doc(FirebaseAuth.instance.currentUser?.uid).set(datosPerfil)
        .onError((e, _) => print("Error writing document: $e"));

    }

  @override
  Widget build(BuildContext context) {


    TextField txtMensaje=TextField(controller: myController, readOnly: true, style: TextStyle(color: Colors.red,fontSize: 16),);

    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text('On Boarding'),
        backgroundColor: Colors.deepPurple,
      ),
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
                    accepPressed(inputNombre.getText(),inputPais.getText(),inputCiudad.getText(),0);
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


