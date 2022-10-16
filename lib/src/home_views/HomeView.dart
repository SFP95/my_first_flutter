import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/singleton/DataHolder.dart';
import '../fb_proyects/Perfil.dart';

class HomeView extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }

}

class _HomeView extends State<HomeView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  String name = " **** ";
  bool blIsRefresBtnVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  void getProfile() async{
    final docRef = db.collection("perfiles").doc(FirebaseAuth.instance.currentUser?.uid)
        .withConverter(fromFirestore: Perfil.fromFirestore,
      toFirestore: (Perfil perfil, _) => perfil.toFirestore(),
    );

    final docSnap = await docRef.get();
    final perfil = docSnap.data(); // Convert to City object

    if (perfil != null) {
      setState(() {
        name=perfil.name!;
      });
    } else {
      print("No such document.");
    }
  }

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
          child:ListView.separated( //me vale para mi proyecto
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: Colors.amber[colorCodes[index]],
                  child: Center(child: Text('Entry ${entries[index]}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                //aqui puedes poner cosas dentros d ela divissiones
                return const Divider();
              },
          ),
      ),
    );
  }
}
