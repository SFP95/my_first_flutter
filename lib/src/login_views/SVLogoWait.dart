import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SVLogoWait extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashVewState();
  }
  
}

class _SplashVewState extends State<SVLogoWait>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllData();
  }

  void loadAllData() async{
    await Future.delayed(Duration(seconds: 2));

    if(FirebaseAuth.instance.currentUser==null){
      setState(() {
        Navigator.of(context).pop('/prueba');
      });
    }
    else{
      bool existe=await checkExistingProfile();
      if(existe){
        setState(() {
          Navigator.of(context).pop('/home');
        });
      }else{
        setState(() {
          Navigator.of(context).pop('/onBoarding');
        });
      }
    }
  }

  Future<bool> checkExistingProfile() async{
    String? idUser=FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore db=FirebaseFirestore.instance;
    final docRef=db.collection("perfiles").doc(idUser);

    DocumentSnapshot docsnap=await docRef.get();
    return docsnap.exists;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/Logo.png")),
            SizedBox(height: 30),
            Text("Cargando Flutter_Chat", style: TextStyle(fontSize: 25),),
            SizedBox(height: 30),
            CircularProgressIndicator(
              semanticsLabel: 'Cirular progress indicator',
            ),
          ],
        )
      ),
    );
  }
}