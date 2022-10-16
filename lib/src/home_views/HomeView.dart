import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/list_items/RoomItem.dart';
import 'package:my_first_flutter/src/singleton/DataHolder.dart';
import '../fb_proyects/Perfil.dart';
import '../fb_proyects/Room.dart';

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
  List<QueryDocumentSnapshot<Room>> chatRooms= [];

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

   void actulizarLista()async{
     final docRef = db.collection("rooms").withConverter(fromFirestore: Room.fromFirestore,
       toFirestore: (Room room, _) => room.toFirestore());

     final docSnap= await docRef.get();

     setState(() {
       for(int i=0;i<docSnap.docs.length;i++){
         chatRooms.add(docSnap.docs[i].data());
       }
     });



   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
          child:ListView.separated( //me vale para mi proyecto
              padding: const EdgeInsets.all(8),
              itemCount: chatRooms.length,
              itemBuilder: (BuildContext context, int index) {
                return RoomItem(
                  Titulo: chatRooms[index].name!,
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
