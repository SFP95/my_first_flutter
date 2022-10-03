import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_views/HomeView.dart';
import 'login_views/LoginPhoneView.dart';
import 'login_views/LoginView.dart';
import 'login_views/RegisterView.dart';

class App extends StatelessWidget{

  const App ({Key?key}):super (key: key);

  String getInitialRoute(){
    if ( FirebaseAuth.instance.currentUser==null){
      return '/loginPhoneView';
    }else{
      return'/home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyfirstFlutter',
      initialRoute: getInitialRoute(),
      routes: {
        '/home':(context) => HomeView(),
        '/loginPhoneView':(context) => LoginPhoneView(),
        '/loginView':(context) => const LoginView(),
        '/registerView':(context) => RegisterView(),

    },
    );
  }

}