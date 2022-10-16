import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase/FbAdmin.dart';

class Perfil { // modificar en base a lo que tenemos en la base de datos del firebase

  final String? city;
  final String? country;
  final int? edad;
  final String? name;
  //final String uid;
  final List<String>? friends;
  final List<DocumentReference>? rooms;


  Perfil({
    this.city="",
    this.country="",
    this.edad=0,
    this.name="",
    //this.uid=""
    this.friends= const [],
    this.rooms= const [],
  });

 /* void iniPerfil(Map <Strign, dynamic> datos){         ALTERNATIVA A LA DE ABAJO, PERSONAL
    name=datos['name'] as String;
  }*/


  factory Perfil.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Perfil(
      city: data?['city'],
      country: data?['country'],
      edad: data?['edad'],
      name: data?['name'],
      friends: data?['friends'] is Iterable ? List.from(data?["friends"]):null,
      rooms: data?['rooms']is Iterable ? List.from(data?["rooms"]):null,
     // uid: snapshot.id
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (city != null) "capital": city,
      if (country != null) "country": country,
      if (edad != 0) "edad": edad,
      if (name != null) "name": name,
      if (friends!.isNotEmpty) "friends": friends,
      if (rooms!.isNotEmpty) "country": rooms,
    };
  }

}