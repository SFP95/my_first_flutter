import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil { // modificar en base a lo que tenemos en la base de datos del firebase

  final String? city;
  final String? country;
  final int? edad;
  final String? name;


  Perfil({
    this.city="",
    this.country="",
    this.edad=0,
    this.name="",
  });

  factory Perfil.fromFirestore( //  hay que descargar su document SnapShot pero no se puede hacer hasta que se tenga bien el firebase
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Perfil(
      city: data?['city'],
      country: data?['country'],
      edad: data!['edad'],
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (city != null) "capital": city,
      if (country != null) "country": country,
      if (edad != null) "edad": edad,
      if (name != null) "name": name,
    };
  }
}