import 'package:cloud_firestore/cloud_firestore.dart';

class Room{
  final String uid;
  final String? nombre;

  Room({
    this.uid="",
    this.nombre=""
});
  factory Room.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return Room(
      nombre: data?['nombre'],
      uid:snapshot.id
  );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
    };
  }

}