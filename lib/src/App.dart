import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/fb_proyects/OnBoardingView.dart';
import 'package:my_first_flutter/src/home_views/SplashView.dart';
import 'fb_proyects/Perfil.dart';
import 'home_views/HomeView.dart';
import 'login_views/LoginPhoneView.dart';
import 'login_views/LoginView.dart';
import 'login_views/RegisterView.dart';

class App extends StatelessWidget{

  const App ({Key?key}):super (key: key);

  String getInitialRoute(){
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
    FirebaseFirestore db=FirebaseFirestore.instance;

    final docRef = db.collection("perfiles").doc(FirebaseAuth.instance.currentUser?.uid).withConverter(
        fromFirestore: Perfil.fromFirestore,
        toFirestore: (Perfil perfil,_)=>perfil.toFirestore());
    final docSnap= await docRef.get();
    return docSnap.exists;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyfirstFlutter',
      initialRoute: '/splashView',//getInitialRoute(),
      routes: {
        '/home':(context) => HomeView(),
        '/loginPhoneView':(context) => LoginPhoneView(),
        '/loginView':(context) =>  LoginView(),
        '/registerView':(context) => RegisterView(),
        '/onBoarding':(context) => OnBoardingView(),
        '/splashView':(context) => SplashView(),

      },
    );
  }

}