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


    String isUserLogged(){

      if ( FirebaseAuth.instance.currentUser==null){
        return '/loginView';
      }else {
        if (checkPerfilExistance() == true) {
          return '/home';
        } else {
          return '/onBoarding';
        }
      }
    }

    Future<bool> checkPerfilExistance() async {

      final docRef = db.collection("perfiles").doc(FirebaseAuth.instance.currentUser?.uid).withConverter(
          fromFirestore: Perfil.fromFirestore,
          toFirestore: (Perfil perfil,_)=>perfil.toFirestore());
      final docSnap= await docRef.get();
      return docSnap.exists;
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