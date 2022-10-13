
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_first_flutter/src/fb_proyects/Perfil.dart';

import '../fb_proyects/Room.dart';
import '../firebase/FbAdmin.dart';

class DataHolder {
  /*mensajes que podemos llevar a todas las pantallas que queremos arrastrar
  por tas las pestallas en las que lo llamemos

  Existe una forma de mata la ejecuión pero aun no lo ha explicado
  */
  static final DataHolder _dataHolder=new DataHolder._internal();

  String sCOLLECTION_ROOMS_NAME="rooms";
  String sCOLLECTION_TEXTS_NAME="texts";

  String sMensaje=" ";
  Perfil perfil=Perfil();
  Room selectedChatRoom = Room();
  FbAdmin fbAdmin = FbAdmin();

  DataHolder._internal(){
    sMensaje="BIENVENIDO ";
  }

  factory DataHolder(){
    return _dataHolder;
  }

  /**
   * @param: none
   * @return Funcion que espera la descarga del perfil y lo guardo en la clase DataHolder
   */
  Future<void> descargarMIPerfil() async{
    perfil=await fbAdmin.descargarPerfil(FirebaseAuth.instance.currentUser?.uid) as Perfil;
  }

  /**
   * @param idPerfil: Id del perfil que quiero descargar.
   * @return Funcion que espera la descarga del perfil y lo guardo en la clase DataHolder
   */
  Future<void> descargarPerfilGenerico(String? idPerfil) async{
    await fbAdmin.descargarPerfil(idPerfil) as Perfil;
  }

  bool isMIPerfilDownloaded(){
    return perfil!=null;
  }
}