import 'package:flutter/cupertino.dart';
import 'package:my_first_flutter/src/App.dart';

void main () async{

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}