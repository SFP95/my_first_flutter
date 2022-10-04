import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/custom_views/RFInputText.dart';

class OnBoardingView extends StatelessWidget{

  OnBoardingView({Key?key}):super(key: key);

  final myController = TextEditingController();
  final RFInputText inputUser=RFInputText(
    titulo: 'Escribe tu usuario:',
    ayuda: 'MrPotato@gmail.com',);
  final RFInputText inputPss=RFInputText(
    titulo: 'Escribe tu Contraseña:',
    ayuda: 'No menos de 8 caracteres',
    blIsPsswd: true,);
  final RFInputText inputRpPss=RFInputText(
    titulo: 'Escribe tu Contraseña:',
    ayuda: 'Repite la contraseña',
    blIsPsswd: true,);


  void btnPressed() async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: inputUser.getText(),
        password: inputPss.getText(),

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

    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text('RegisterView'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center( //aqui tenia el error

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputUser,
            inputPss,
            inputRpPss,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:(){
                    if(inputPss.getText()==inputRpPss.getText()){
                      void btnPressed(BuildContext context) async{
                        // print("FUNCIONO"+psswd.geText());
                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: inputUser.getText(),
                            password: inputPss.getText(),
                          );
                          print(' -- ESTOY DENTRO ---- Bienvenido '+inputUser.getText());
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
                      txt.text="ERROR! LAS CONSTRASELAS NO COINCIDEN";
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
                  ),
                ),
              ],
            )],
        ),
      ),

    );

  }

}