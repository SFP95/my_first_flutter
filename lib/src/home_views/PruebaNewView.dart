import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/home_views/HomeView.dart';

import '../App.dart';
import '../fb_proyects/Perfil.dart';
import '../singleton/DataHolder.dart';

class PruebaNewView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('My Navigation Drawer'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.purple[50],
        child: ListView(
          children: [
            Divider(
              height: 1,
              thickness: 7,
            ),
            ListTile(
              leading: Icon(Icons.login),
              textColor:Colors.deepPurple,
              iconColor: Colors.deepPurple,
              title: Text('Login'),
              onTap: (){
                Navigator.of(context).popAndPushNamed('/loginView');
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              textColor:Colors.deepPurple,
              iconColor: Colors.deepPurple,
              title: Text('Registro'),
              onTap: (){
                Navigator.of(context).popAndPushNamed('/registerView');
                },
            ),
            ListTile(
              leading: Icon(Icons.phone_android),
              textColor:Colors.deepPurple,
              iconColor: Colors.deepPurple,
              title: Text('Phone Login'),
              onTap: (){
                Navigator.of(context).popAndPushNamed('/loginPhoneView');
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
                Navigator.of(context).popAndPushNamed('/loginView');
              },
            ),
          ],
        ),
      ),
    );
  }
  
}
  
