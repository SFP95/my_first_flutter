import 'package:flutter/cupertino.dart';
import 'package:my_first_flutter/src/App.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';


void main () async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
       App());
}