
import 'package:my_first_flutter/src/fb_proyects/Perfil.dart';

class DataHolder {
  static final DataHolder _dataHolder=new DataHolder._internal();

  String sMensaje=" ";
  Perfil perfil=Perfil();

  /*static DataHolder get instance{

    return _dataHolder;
  }*/

  DataHolder._internal(){
    sMensaje="BIENVENIDO ";
  }

  factory DataHolder(){

    return _dataHolder;
  }
}