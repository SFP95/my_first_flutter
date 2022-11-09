import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/home_views/OnBoardingView.dart';
import 'package:my_first_flutter/src/login_views/SVLogoWait.dart';
import 'package:my_first_flutter/src/singleton/DataHolder.dart';
import 'home_views/ChatViews.dart';
import 'home_views/HomeView.dart';
import 'home_views/PruebaNewView.dart';
import 'login_views/LoginPhoneView.dart';
import 'login_views/LoginView.dart';
import 'login_views/RegisterView.dart';

class App extends StatelessWidget{

   App ({Key?key}):super (key: key);
  FirebaseFirestore db = FirebaseFirestore.instance;
/*
  String getInitalRoute(){
    if(FirebaseAuth.instance.currentUser==null){
      return '/splashView';
    }
    else{
      return '/loginView';
    }
  }*/

  @override
  Widget build(BuildContext context) {

    MaterialApp materialAppMobile=const MaterialApp();

     if(DataHolder().platformAdmin.isAndroidPlatform() ||
         DataHolder().platformAdmin.isIOSPlatform()){
        //print("ENTRO EN ANDROID O IOS");
       materialAppMobile=MaterialApp(
         title: 'MyfirstFlutter',
         initialRoute: '/splashView',
         routes: {
           '/home': (context) => HomeView(),
           '/loginPhoneView': (context) => LoginPhoneView(),
           '/loginView': (context) => LoginView(),
           '/registerView': (context) => RegisterView(),
           '/onBoarding': (context) => OnBoardingView(),
           '/splashView': (context) => SVLogoWait("assets/images/Logo.png"),
           //'/prueba': (context) => PruebaNewView(),
           '/chatView': (context) => ChatView(),
         },
       );
     }
     else if(DataHolder().platformAdmin.isWebPlatform()){
       materialAppMobile=MaterialApp(
         initialRoute: '/splashView',
           routes: {
             '/home': (context) => HomeView(),
             '/loginPhoneView': (context) => LoginPhoneView(),
             '/loginView': (context) => LoginView(),
             '/registerView': (context) => RegisterView(),
             '/onBoarding': (context) => OnBoardingView(),
             '/splashView': (context) => SVLogoWait("assets/images/Logo.png"),
             //'/prueba': (context) => PruebaNewView(),
             '/chatView': (context) => ChatView(),
           },
       );
     }
    //print("La PLATAFORMA ES ..... --> "+DataHolder().platformAdmin.isAndroidPlatform().toString());

    return materialAppMobile;
     }
  }
