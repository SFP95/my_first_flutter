import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget{

  final String Titulo;
  final Function(int index) onShortClick;
  final int index;

  const RoomItem({Key? key, this.Titulo="Titulo", required this.onShortClick,
    required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(Titulo),
      subtitle: Text("Texto secundario"),
      leading: Icon(Icons.label),
      onTap: (){
        onShortClick(index);
      },
    );
  }

}