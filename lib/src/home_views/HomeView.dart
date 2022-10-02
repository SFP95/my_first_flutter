import 'package:flutter/material.dart';

class HomeView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }

}

class _HomeView extends State<HomeView>{

  //FirebaseFirestore bd= FirebaseFirestore.instance;
  String nombre="AQUI VA EL NOMBRE";

  void getProfile() async{
    final docRef = db.collection("perfiles").doc(FireBaseAuth.instance,currentUser?.uid);

    await docRef.get().then(
        (DocumentSnapshot doc){
          final data = doc.data() as Map <String, dynamic>;
          print(" --- >> "+data?['nombre']);

          setState(() {
            nombre=data?['nombre'];
          });
        }
    );
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
            Text("HOME VIEW -- BIENVENIDO: "+nombre)
          ],
        ),
      ),
    );
  }
}