
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter/src/grids_items/RoomCard.dart';
import 'package:my_first_flutter/src/list_items/RoomItem.dart';
import 'package:my_first_flutter/src/singleton/DataHolder.dart';
import '../fb_proyects/Perfil.dart';
import '../fb_proyects/Room.dart';

class HomeView extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }

}

class _HomeView extends State<HomeView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String name = " **** ";
  bool blIsRefresBtnVisible = true;
  List<Room> chatRooms= [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //getProfile();
    actualizarLista();
  }


    void getRoomList() async{
      // String Query= SELECT * FROM ROOMS WHERE members>50;
      final docRef=db.collection('rooms').where('members', isGreaterThan:50).orderBy('memvers',descending: true)
          .withConverter(
          fromFirestore: Room.fromFirestore,
          toFirestore: (Room room, _) => room.toFirestore());

      //stmt.exexuteQuery(Query);
      final docSnap= await docRef.get();

      setState(() {
        for(int i=0;i<docSnap.docs.length;i++){
          chatRooms.add(docSnap.docs[i].data());
        }
      });
    }


   void actualizarLista()async{
     final docRef = db.collection("rooms").withConverter(fromFirestore: Room.fromFirestore,
       toFirestore: (Room room, _) => room.toFirestore());

     final docSnap= await docRef.get();

     setState(() {
       for(int i=0;i<docSnap.docs.length;i++){
         chatRooms.add(docSnap.docs[i].data());
       }
     });
   }

   void listItemShortClicked(int index){
     print("DEBUG: "+index.toString());
     print("DEBUG: "+chatRooms[index].name!);
    // DataHolder().selectedChatRoom=chatRooms[index];
     Navigator.of(context).pushNamed('/chatView');
   }

  @override
  Widget build(BuildContext context) {
   // List<String> listaNombres=["Alba",'Rafa','Jess','Carol','Fouad','Nia'];

    return Scaffold(
        backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('HOME'),
      ),
      body: Center(
        child:
        GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      ),
        itemCount: chatRooms.length,
        itemBuilder: (BuildContext context, int index) {
          return RoomCard(
              imgURL: chatRooms[index].image!,
              name: chatRooms[index].name!,
              onShorClick: listItemShortClicked,
              index: index,
          );
        }
    ),
      )
    );
  }
}



/*child:ListView.separated( //me vale para mi proyecto
              padding: const EdgeInsets.all(8),
              itemCount: chatRooms.length,
              itemBuilder: (BuildContext context, int index) {
                return RoomItem(
                  Titulo: chatRooms[index].name!,
                  onShortClick: listItemShortClicked,index: index,);
              },
              separatorBuilder: (BuildContext context, int index) {
                //aqui puedes poner cosas dentros d ela divissiones
                return const Divider();
              },
          ),*/