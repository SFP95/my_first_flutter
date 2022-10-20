import 'package:cloud_firestore/cloud_firestore.dart';

class Room{
  final String uid;
  final String? name;
  final String? image;
  final int members;

  Room({
    this.uid="",
    this.name="",
    this.image="",
    this.members=0,

  });
  factory Room.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return Room(
      name: data?['name'],
      image: data?['image'],
      members: data?['members'],
      uid:snapshot.id
  );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (image != null) "image": image,
      if (members != null) '"members': members,
    };
  }

}