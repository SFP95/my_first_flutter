import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../fb_proyects/Perfil.dart';
import '../singleton/DataHolder.dart';

class PruebaNewView extends StatefulWidget{
   late String title="MyApp";
   late final FirebaseFirestore db= FirebaseFirestore.instance;




  @override
  State<StatefulWidget> createState() {
    return _PruebaNewView();
  }

   /*void actualizarNombre() async{
     String nombre=" **** ";

     String? IdUser=FirebaseAuth.instance.currentUser?.uid;

     final docRef = db.collection("perfiles").doc(IdUser).withConverter(
         fromFirestore: Perfil.fromFirestore,
         toFirestore: (Perfil perfil,_)=>perfil.toFirestore());

     final docSnap = await docRef.get();
     final perfilUser = docSnap.data(); // Convert to City object

     if (perfilUser != null) {
       print(perfilUser);
       setState(() {
         nombre=perfilUser.name!;
       });
     } else {
       print("No such document.");
     }
   }*/

}
class _PruebaNewView extends State<PruebaNewView>{

  int _selectedDestination = 0;
  bool blIsRefresBtnVisible=true;
  String nombre=" **** ";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        backgroundColor: Colors.black12,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Header',
                style: textTheme.headline6,
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: Icon(Icons.app_registration),
              title: Text('Registro'),
              selected: _selectedDestination == 0,
              onTap: () => selectDestination(0),
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: Icon(Icons.phone_android),
              title: Text('Tlf'),
              selected: _selectedDestination == 1,
              onTap: () => selectDestination(1),
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: Icon(Icons.login),
              title: Text('Login'),
              selected: _selectedDestination == 2,
              onTap: () => selectDestination(2),
            ),
            Divider(
              color: Colors.black54,
              height: 1,
              thickness: 1,
            ),

            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              leading: Icon(Icons.delete),
              title: Text('Logout'),
              selected: _selectedDestination == 3,
              onTap: () => selectDestination(3),

            ),
          ],
        ),
      ),
      body:
      GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        padding: EdgeInsets.all(20),
        childAspectRatio: 3 / 2,
        children:[
          Text("BIENVENIDO: "+nombre),
          if (blIsRefresBtnVisible)ElevatedButton(
              onPressed: (){
              //  actualizarNombre();
              },
              // Respond to button press

              child:
              Text("Refrescar!"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[900],
              )),
          /*ElevatedButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).popAndPushNamed('/loginView');
              },
              // Respond to button press
              child: Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[900],
              ))*/
        ],
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
  
