
import 'package:my_first_flutter/src/fb_proyects/Perfil.dart';

class DataHolder {
  /*mensajes que podemos llevar a todas las pantallas que queremos arrastrar
  por tas las pestallas en las que lo llamemos

  Existe una forma de mata la ejecuión pero aun no lo ha explicado
  */
  static final DataHolder _dataHolder=new DataHolder._internal();


  String sMensaje=" ";
  Perfil perfil=Perfil();

  DataHolder._internal(){
    sMensaje="BIENVENIDO ";
  }

  factory DataHolder(){

    return _dataHolder;
  }
}