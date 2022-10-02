import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/custom_views/RFInputText.dart';

class LoginView extends StatelessWidget{

  const LoginView ({Key?key}):super (key: key);

  void LogPressed(String emailAddress, String password, BuildContext context) async{
    try{
      final credential= await FirebaseAuth.instance.singInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print("ESTOY LOGEADO");
      Navigator.of(context).popAndPushNamed('/home');
    }on FirebaseAuthException catch (e){
      if(e.code=='user-not-found'){
        print('No user found for that email');
      }else if(e.code=='wrong-password'){
        print('Wrong password provided for that user');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    RFInputText inputUser= RFInputText(titulo: 'USUARIO:',ayuda: 'MrPotato@gmai.com',);
    RFInputText inputPsswd= RFInputText(titulo: 'PASSWORD:',ayuda: 'No menos de 6 caracteres',);

    return Scaffold(
      appBar: AppBar(
        title: Text('/loginView'),
    ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputUser,
            inputPsswd,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                    void btnPressed(BuildContext context) async{
                      // print("FUNCIONO"+psswd.geText());
                      try {
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: input1.geText(),
                          password: psswd.geText(),
                        );
                        print(' -- ESTOY DENTRO ---- Bienvenido '+input1.geText());
                        Navigator.of(context).popAndPushNamed('/Home');

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
                  },

                  child: Text("LOGIN"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[900],
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('/RegisterView');
                    },
                    // Respond to button press

                    child: Text("REGISTRO"),
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