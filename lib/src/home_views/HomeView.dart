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

  String nombre = " **** ";
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
        nombre=perfil.city!;
      });
    } else {
      print("No such document.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DataHolder().sMensaje + "-- A HOME: " + nombre),
            if (blIsRefresBtnVisible)ElevatedButton(
                onPressed: () {
                  getProfile();
                },
                // Respond to button press

                child: Text("Refrescar!"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[900],
                )),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).popAndPushNamed('/loginView');
                },
                // Respond to button press
                child: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[900],
                ))
          ],
        ),
      ),
    );
  }
}

/**
 * void actualizarNombre() async {
    String? IdUser = FirebaseAuth.instance.currentUser?.uid;
    final docRef = db.collection("perfiles").doc(IdUser).withConverter(
    fromFirestore: Perfil.fromFirestore,
    toFirestore: (Perfil perfil, _) => perfil.toFirestore());

    final docSnap = await docRef.get();
    final perfilUser = docSnap.data(); // Convert to City object

    if (perfilUser != null) {
    print(perfilUser);
    setState(() {
    nombre = perfilUser.name!;
    });
    } else {
    print("No such document.");
    }
    }
 */