import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_flutter/src/fb_proyects/Perfil.dart';

class FbAdmin {
  FirebaseFirestore db = FirebaseFirestore.instance;

  FbAdmin(){
    Future<Perfil?> desgarPerfil(String? idPerfil) async{
      final docRef = db.collection("perfiles").doc(idPerfil).withConverter(
        fromFirestore: Perfil.fromFirestore,
        toFirestore: (Perfil perfil, _) => perfil.toFirestore(),
      );
      final docSnap = await docRef.get();
      return docSnap.data();
    }
  }
}


