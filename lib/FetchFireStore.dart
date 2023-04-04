import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FetchFireStore extends StatefulWidget {
  const FetchFireStore({super.key});

  @override
  State<FetchFireStore> createState() => _FetchFireStoreState();
}

class _FetchFireStoreState extends State<FetchFireStore> {
  @override
  var ref=FirebaseFirestore.instance.collection("users").snapshots();
  var ct=FirebaseFirestore.instance.collection("users");
  String name="Lalit";
  var controller=TextEditingController();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            SizedBox(height: 20,),
            TextFormField(
              onChanged: (val){
              name=val;
              setState(() {
                
              });
              },
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: IconButton(icon: Icon(Icons.search),onPressed: (){
                name=controller.text;
                setState(() {
                  
                });
                },),
                border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: ref,
                builder: (context,snapshot){
               
                if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context,index){
                  if((snapshot.data!.docs[index]["name"]).toString().contains(name)){
                  return
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(snapshot.data?.docs[index]["name"]),
                    trailing: PopupMenuButton(itemBuilder:(context)=>[
                    PopupMenuItem(child: TextButton(child: Text("Update"),onPressed: (){
                    Navigator.pop(context);
                    showMyDialog(context,ct,snapshot.data?.docs[index]["id"]);
                    })),
                    PopupMenuItem(child: TextButton(child: Text("Delete"),onPressed: (){
                    ct.doc(snapshot.data!.docs[index].id).delete();
                    Navigator.pop(context);
                    },))
                    ]),
                  );}
                }) ;}
                return Text("Loading...");
                }),
            ),
          ]),
        ),
      ),
    );
  }
}
Future<void>showMyDialog(BuildContext context,CollectionReference<Map<String, dynamic>>ct,String id){
  var cnt=TextEditingController();
  return showDialog(context: context, builder:(context){
    return AlertDialog(
      title: Text("Enter the value:"),
      content: Padding(padding: EdgeInsets.all(1),
      child: TextField(
        controller: cnt,
        decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
      ),),
      actions: [
        TextButton(child: Text("Cancel"),onPressed: (){Navigator.pop(context);},),
        TextButton(onPressed: (){
          Navigator.pop(context);
          ct.doc(id).update({"name":cnt.text}).then((value) => {print("Done")}).onError((error, stackTrace) => {print(error)});
        }, child:Text("Update"))
      ],
    );
  });
}