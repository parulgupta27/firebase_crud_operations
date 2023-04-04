import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class InsertIntoFireStore extends StatefulWidget {
  const InsertIntoFireStore({super.key});

  @override
  State<InsertIntoFireStore> createState() => _InsertIntoFireStoreState();
}

class _InsertIntoFireStoreState extends State<InsertIntoFireStore> {
  @override
  var tc=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        TextField(
          controller: tc,
          decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
        ),
        ElevatedButton(onPressed: ()async{
        String id=DateTime.now().microsecondsSinceEpoch.toString();
        var firestore=FirebaseFirestore.instance;
        var doc=firestore.collection("users").doc(id);
        await doc.set({
        'id':id,
        'name':tc.text,
        }).then((value) => {
          print("Done")
        }).onError((error, stackTrace) => {
        print(error)
        });
        tc.clear();
        }, child: Text("Insert"),),
        ]),
      ),
    );
  }
}