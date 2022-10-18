import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/fb_proyects/OnBoardingView.dart';
import 'package:my_first_flutter/src/home_views/ChatViews.dart';
import 'package:my_first_flutter/src/home_views/HomeView.dart';
import 'package:my_first_flutter/src/login_views/SplashView.dart';
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
        case 3: return ChatView();
        case 4: return OnBoardingView();
      }
    }

    _onSelectDrawer(int pos){
      setState((){
        Navigator.of(context).pop();
        selectDrawer = pos;
      });
    }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.purple[100],
    appBar: AppBar(
    backgroundColor: Colors.deepPurple,
    title: Text('My App'),
    ),
    drawer: Drawer(
      backgroundColor: Colors.black38,
      child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName:
            Text('UserName',
                style:TextStyle(
                    fontSize:21,
                    color:Colors.purple[900])),
          accountEmail:
            Text('email@gmail.com',
                style:TextStyle(
                    fontSize:15,
                    color:Colors.purple[900])),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:[
                Colors.purple.shade200,
                Color(0xFFBA68C8),
                Colors.purple.shade800
              ],
            ),
            borderRadius: BorderRadius.circular(10),

          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor:Colors.deepPurple,
            child:
              Text('N',
                style:TextStyle(fontSize: 40.0, color: Colors.purple[200]) ,),
            ),
        ),
        
        ListTile(
          leading: Icon(Icons.chat_bubble),
          textColor:Colors.purple.shade200,
          iconColor: Colors.white24,
          selected: (3== _onSelectDrawer),
          title: Text('ChatView'),
          onTap: (){
            _onSelectDrawer(3);
          },
        ),
        ListTile(
          leading: Icon(Icons.phone_android),
          textColor:Colors.purple.shade200,
          iconColor: Colors.white24,
          selected: (2== _onSelectDrawer),
          title: Text('Phone Login'),
          onTap: (){
            _onSelectDrawer(2);
          },
        ),
        ListTile(
          leading: Icon(Icons.border_all),
          textColor:Colors.purple.shade200,
          iconColor: Colors.white24,
          selected: (4== _onSelectDrawer),
          title: Text('On Boarding'),
          onTap: (){
            _onSelectDrawer(4);
          },
        ),

        Divider(
          color: Colors.white24,
          height: 1,
          thickness: 2,
        ),
        ListTile(
          leading: Icon(Icons.app_registration),
          textColor:Colors.purple.shade200,
          iconColor: Colors.white24,
          selected: (1== _onSelectDrawer),
          title: Text('Registro'),
          onTap: (){
          _onSelectDrawer(1);
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          textColor:Colors.purple.shade200,
          iconColor: Colors.white24,
          title: Text('Logout'),
          onTap: (){
            _onSelectDrawer(0);
          },
        ),
        ],
      ),
      ),
    body: _getDrawerWindow(selectDrawer),
    );
  }
  }




  

  
