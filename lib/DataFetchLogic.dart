import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
class FetchData extends StatefulWidget {
  const FetchData({super.key});
  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  var db=FirebaseDatabase.instance;
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 200,),
          Text("Data"),
          Expanded(
            child: FirebaseAnimatedList(query: db.ref("post"), itemBuilder: (context,snapshot,dble,index){
              return ListTile(
                leading: Icon(Icons.person),
                subtitle: Text(snapshot.child("name").value.toString()),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(child: TextButton(onPressed: () => {
                    Navigator.pop(context),
                    showMyDialog(context,db.ref("post") ,snapshot.child("id").value.toString() )
                    },child: Text("Update"),),),
                    PopupMenuItem(child: TextButton(child: Text("Delete"),onPressed: (){
                      Navigator.pop(context);
                      db.ref("post").child(snapshot.child("id").value.toString()).remove().then((value) => {print("Done")}).onError((error, stackTrace) => {
                        print(error)
                      });
                    },),),
                  ],
                ),
              );
            },),
          ),
        ],
      ),
    );
  }
}
Future<void> showMyDialog(BuildContext context,DatabaseReference ref,String id){
  return showDialog(context: context, builder: (context){
    var cnt=TextEditingController();
    return AlertDialog(
      title:Text("Update Your Data Here"),
      content: Padding(padding: EdgeInsets.all(5),
      child: TextField(
        controller: cnt,
      decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
      ),
    
      ),
      actions: [
        TextButton(onPressed: (){
        Navigator.pop(context);
        }, child: Text("Cancel")),
        TextButton(onPressed: (){
        Navigator.pop(context);
        ref.child(id).update({
          "name":cnt.text
        }).then((value) => {print("Done")}).onError((error, stackTrace) => {print(error)});
        }, child: Text("Update"))
      ],
    );
  });
}