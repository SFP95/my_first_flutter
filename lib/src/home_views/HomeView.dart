import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../fb_proyects/Perfil.dart';

class HomeView extends StatefulWidget{
 // final FirebaseFirestore db= FirebaseFirestore.instance;

  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }

}

class _HomeView extends State<HomeView>{

  FirebaseFirestore db= FirebaseFirestore.instance;
  String nombre=" **** ";
  bool blIsRefresBtnVisible=true;

  void getProfile() async{

    //final docRef = db.collection("perfiles").doc(FireBaseAuth.instance,currentUser?.uid);
    /*final docRef = db.collection("perfiles").doc(
      FirebaseAuth.instance.currentUser?.withConverter (fromFirestore: Perfil) //sin acabar
    );

    final docSnap = await ref.get();
    final city = docSnap.data(); // Convert to City object

    if (city != null) {
      print(city);
    } else {
      print("No such document.");
    }*/

   /* await docRef.get().then(
        (DocumentSnapshot doc){
          final data = doc.data() as Map <String, dynamic>;
          print(" --- >> "+data?['nombre']);

          setState(() {
            nombre=data?['nombre'];
          });
        }
    );*/
  }

  void actualizarNombre(){

    final docRef = db.collection("perfiles").doc("zp56k7dZiWeXnJbpVq41");

    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );


    setState(() {
      nombre="";
      blIsRefresBtnVisible=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyFirstFlutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME VIEW -- BIENVENIDO: "+nombre),
            if (blIsRefresBtnVisible)ElevatedButton(
                onPressed: (){
                 actualizarNombre();
                },
                // Respond to button press

                child: Text("Refrescar!"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[900],
                ))
          ],
        ),
      ),
    );
  }
}