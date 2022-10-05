
class DataHolder {
  static final DataHolder _dataHolder=new DataHolder._internal();

  String sMensaje=" ";

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