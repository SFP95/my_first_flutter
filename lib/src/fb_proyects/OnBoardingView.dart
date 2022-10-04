import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/custom_views/RFInputText.dart';

class RegisterView extends StatelessWidget{

  RegisterView({Key?key}):super(key: key);

  final myController = TextEditingController();
  final input=RFInputText(titulo: 'USUARIO: ',);
  final psswd=RFInputText();
  final psswdConf=RFInputText();

  void btnPressed() async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: input.getText(),
        password: psswd.getText(),

      );
      print(' -- La cuenta ha sido creada --');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('----- La contraseña es debil -----');
      } else if (e.code == 'email-already-in-use') {
        print('---- Ya existe una cuenta con ese email -----');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {



    var txt=TextEditingController();
    TextField txtMensaje=TextField(controller: myController, readOnly: true, style: TextStyle(color: Colors.red,fontSize: 16),);

    return MaterialApp(
      home: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            input,
            psswd,
            psswdConf,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:(){
                    if(psswd.getText()==psswdConf.getText()){
                      void btnPressed(BuildContext context) async{
                        // print("FUNCIONO"+psswd.geText());
                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: input.getText(),
                            password: psswd.getText(),
                          );
                          print(' -- ESTOY DENTRO ---- Bienvenido '+input.getText());
                          Navigator.of(context).popAndPushNamed('/loginView');

                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            txt.text="----- The password provided is too weak -----";
                          } else if (e.code == 'email-already-in-use') {
                            txt.text="---- Ya existe una cuenta con ese email -----";
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    }else{
                      txt.text="ERROR ! LAS CONSTRASELAS NO COINCIDEN";
                    }
                  },

                  child: Text("Aceptar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[900],
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).popAndPushNamed('/loginView');
                    },
                    // Respond to button press

                    child: Text("Cancelar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[900],
                    ))
              ],
            )],
        ),
      ),

    );

  }

}