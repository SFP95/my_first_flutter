import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/singleton/DataHolder.dart';
import '../fb_proyects/Perfil.dart';

class SplashView extends StatefulWidget{

//es para las cosas visuales de la aplicacion, los efectos visuales

  @override
  State<StatefulWidget> createState() {
    return _SplashView();
  }

}

class _SplashView extends State<SplashView>{
  FirebaseFirestore db= FirebaseFirestore.instance;

@override
  void initState(){
    super.initState();
    isUserLogged();
  }

    void isUserLogged()async{
         await Future.delayed(Duration(seconds: 5));

      if ( FirebaseAuth.instance.currentUser==null){
        Navigator.of(context).popAndPushNamed('/prueba');
      }else {
        if (checkPerfilExistance() == true) {
          Navigator.of(context).popAndPushNamed('/prueba');
        } else {
          Navigator.of(context).popAndPushNamed('/onBoarding');
        }
      }
    }

    Future<bool> checkPerfilExistance() async {

      final docRef = db.collection("perfiles").doc(FirebaseAuth.instance.currentUser?.uid).withConverter(
          fromFirestore: Perfil.fromFirestore,
          toFirestore: (Perfil perfil,_)=>perfil.toFirestore());
      final docSnap= await docRef.get();
      DataHolder().perfil=docSnap.data()!;
      return docSnap.exists;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BIENVENIDO A FLUTTER CHAT !"),
          ],
        ),
      ),
    );
  }
}