import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/home_views/OnBoardingView.dart';
import 'package:my_first_flutter/src/login_views/SVLogoWait.dart';
import 'package:my_first_flutter/src/login_views/SplashView.dart';
import 'package:my_first_flutter/src/list_items/ChatItem.dart';
import 'fb_proyects/Perfil.dart';
import 'home_views/ChatViews.dart';
import 'home_views/HomeView.dart';
import 'home_views/PruebaNewView.dart';
import 'login_views/LoginPhoneView.dart';
import 'login_views/LoginView.dart';
import 'login_views/RegisterView.dart';

class App extends StatelessWidget{

   App ({Key?key}):super (key: key);
  FirebaseFirestore db = FirebaseFirestore.instance;

  String getInitalRoute(){
    if(FirebaseAuth.instance.currentUser==null){
      return '/splashView';
    }
    else{
      return '/splashView';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyfirstFlutter',
      initialRoute: getInitalRoute(),
      routes: {
        '/home':(context) => HomeView(),
        '/loginPhoneView':(context) => LoginPhoneView(),
        '/loginView':(context) =>  LoginView(),
        '/registerView':(context) => RegisterView(),
        '/onBoarding':(context) => OnBoardingView(),
        '/splashView':(context) => SVLogoWait(),
        '/prueba': (context) => PruebaNewView(),
        '/chatView': (context) => ChatView(),
      },
      home: LoginView(),
      theme: ThemeData(
          primaryColor: Color(101935),
          accentColor: Color(564787)
      ),
    );
  }

}