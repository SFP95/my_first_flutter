import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/home_views/HomeView.dart';
import 'package:my_first_flutter/src/login_views/LoginPhoneView.dart';
import 'package:my_first_flutter/src/login_views/LoginView.dart';
import 'package:my_first_flutter/src/login_views/RegisterView.dart';

import '../App.dart';
import '../fb_proyects/Perfil.dart';
import '../singleton/DataHolder.dart';

class PruebaNewView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PruebaNewView();
  }

}
  class _PruebaNewView extends State<PruebaNewView>{


      int selectDrawer=0;


    _getDrawerWindow(int pos){
      switch(pos){
        case 0: return LoginView();
        case 1: return RegisterView();
        case 2: return LoginPhoneView();
        case 3: return LoginView();
      }
    }

    _onSelectDrawer(int pos){
      setState((){
        selectDrawer = pos;
      });
    }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.purple[50],
    appBar: AppBar(
    backgroundColor: Colors.deepPurple,
    title: Text('My App'),
    ),
    drawer: Drawer(
      backgroundColor: Colors.purple[50],
      child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('UserMAil'),
          accountEmail: Text('email@gmail.com'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.deepPurple,
            child:
              Text('N',
                style:TextStyle(fontSize: 40.0) ,),
            ),
        ),
        Divider(
          height: 1,
          thickness: 7,
        ),
        ListTile(
          leading: Icon(Icons.app_registration),
          textColor:Colors.deepPurple,
          iconColor: Colors.deepPurple,
          title: Text('Registro'),
          onTap: (){
            _onSelectDrawer(1);
          },
        ),
        ListTile(
          leading: Icon(Icons.phone_android),
          textColor:Colors.deepPurple,
          iconColor: Colors.deepPurple,
          title: Text('Phone Login'),
          onTap: (){
            _onSelectDrawer(2);
          },
        ),
        Divider(
          height: 1,
          thickness: 7,
        ),
        ListTile(
          leading: Icon(Icons.logout),
          textColor:Colors.deepPurple,
          iconColor: Colors.deepPurple,
          title: Text('Logout'),
          onTap: (){
            _onSelectDrawer(3);
          },
        ),
        ],
      ),
      ),
    body: _getDrawerWindow(selectDrawer),
    );
  }
  }




  

  
