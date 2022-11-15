import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_first_flutter/src/singleton/DataHolder.dart';


class SVLogoWait extends StatefulWidget{

  final String logoPath;
  const SVLogoWait(this.logoPath, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _SVLogoWait();
  }
}

class _SVLogoWait extends State<SVLogoWait>{

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  void loadAllData() async{
    await Future.delayed(Duration(seconds: 2));

    print("PASO POR AQUI part 1");
    // FirebaseAuth.instance.currentUser
    // DataHolder().perfil.uid

    if(DataHolder().perfil.uid==null){
      setState(() {
        print("PASO POR AQUI part 2.1");

        Navigator.of(context).popAndPushNamed('/loginView');
      });
    }
    else{
      bool existe=await checkExistingProfile();
      if(existe){
        setState(() {
          print("PASO POR AQUI part 2.2");
          Navigator.of(context).popAndPushNamed('/home');
        });
      }else{
        setState(() {
          Navigator.of(context).popAndPushNamed('/registerView');
        });
      }
    }
  }

  Future<bool> checkExistingProfile() async{
    // FirebaseAuth.instance.currentUser?.uid  DataHolder().perfil.uid
    String? idUser=FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore db=FirebaseFirestore.instance;
    final docRef=db.collection("perfiles").doc(idUser);

    DocumentSnapshot docsnap=await docRef.get();
    return docsnap.exists;
  }


  @override
  Widget build(BuildContext context) {
    DataHolder().platformAdmin.initDisplayData(context);
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(widget.logoPath)),
            const SizedBox(height: 30),
            const Text("Cargando...", style: TextStyle(fontSize: 25),),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              semanticsLabel: 'Cirular progress indicator',
            ),
          ],
        )
      ),
    );
  }
}