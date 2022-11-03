import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SVLogoWait extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashVewState();
  }
  
}

class _SplashVewState extends State<SVLogoWait>{
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