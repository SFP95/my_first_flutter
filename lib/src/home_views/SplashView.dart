import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../fb_proyects/Perfil.dart';

class SplashView extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return _SplashView();
  }

}

class _SplashView extends State<SplashView>{
  FirebaseFirestore db= FirebaseFirestore.instance;

  String nombre=" **** ";
  bool blIsRefresBtnVisible=true;


  void actualizarNombre() async{

    String? IdUser=FirebaseAuth.instance.currentUser?.uid;
    final docRef = db.collection("perfiles").doc(IdUser).withConverter(
        fromFirestore: Perfil.fromFirestore,
        toFirestore: (Perfil perfil,_)=>perfil.toFirestore());

    final docSnap = await docRef.get();
    final perfilUser = docSnap.data(); // Convert to City object

    if (perfilUser != null) {
      print(perfilUser);
      setState(() {
        nombre=perfilUser.name!;
      });
    } else {
      print("No such document.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BUENVENIDO A FLUTTER CHAT !"),
          ],
        ),
      ),
    );
  }
}