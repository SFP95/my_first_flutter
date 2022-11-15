import 'package:cloud_firestore/cloud_firestore.dart';

class FBText {


  final String? text;
  final String? idUser;
  final Timestamp? time;

  FBText({
    this.text="",
    this.idUser="",
    this.time,
  });

  factory FBText.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FBText(
      text: data?['text'],
      idUser: data?['idUser'],
      time: data?['time'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (text != null) "text": text,
      if (idUser != null) "idUser": idUser,
      if (time != null) "time": time,
    };
  }
}