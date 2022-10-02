import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/custom_views/RFInputText.dart';

class LoginPhoneView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPhoneView();
  }

}

class _LoginPhoneView extends State<LoginPhoneView>{

  RFInputText inputPhone=RFInputText();
  RFInputText inputCode=RFInputText();
  bool blIsWaitingForSMS=false;
  late String verificationID;

  void enviarTlf(String phoneNumber, BuildContext context) async{

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async{
        await FirebaseAuth.instance.signInWithCredential(credential);
        print(' -- ME HE LOGUEADO --');
        Navigator.of(context).popAndPushNamed('/Home');
      },
      verificationFailed: (FirebaseAuthException e) {

      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationID=verificationId;
        setState(() {
          blIsWaitingForSMS=true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }

  void enviarCode(String smsCode, BuildContext context) async{
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    print(' -- ME HE LOGUEADO --');
    Navigator.of(context).popAndPushNamed('/Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.deepPurple[100],
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputPhone,
            ElevatedButton(
              onPressed: (){
                enviarTlf(inputPhone.getText(),context);
              },
              child: Text("Enviar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[900],
              ),
            ),
            if(blIsWaitingForSMS)inputCode,
            if(blIsWaitingForSMS)ElevatedButton(
              onPressed: (){
                enviarCode(inputCode.getText(),context);
              },
              child: Text("Enviar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}