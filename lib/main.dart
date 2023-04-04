import 'package:crud/AuthScreen.dart';
import 'package:crud/DataFetchLogic.dart';
import 'package:crud/EmailAuth.dart';
import 'package:crud/FetchFireStore.dart';
import 'package:crud/FireStore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "imageUpload.dart";
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home:AuthScreen()));
}
class Crud extends StatefulWidget {
  const Crud({super.key});

  @override
  State<Crud> createState() => _CrudState();
}
class _CrudState extends State<Crud> {
  @override
  String cntroll="Hello";
  void setText()async{
  var ref=await SharedPreferences.getInstance();
   String text=ref.getString("name").toString();
   cntroll=text;
   print(text);
  }
          void initState() {
    super.initState();
    setText();
  }
    var realtime=FirebaseDatabase.instance.ref("post");
  Widget build(BuildContext context) {
    var controller=new TextEditingController();
  
    return Scaffold(

      body: SafeArea(
        child: Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200,),
              TextField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()async{
                var ref=await SharedPreferences.getInstance();
                ref.setString("name",controller.text);
                cntroll=controller.text;
                controller.clear();
                setState(() {
                  
                });
                String s=DateTime.now().millisecondsSinceEpoch.toString();
                realtime.child(s).set({'id':s,
                'name':controller.text});
                
              // var firestore=FirebaseFirestore.instance;
              // var doc=firestore.collection("users").add({"name":controller.text});
              }, child: Text(cntroll,style: TextStyle(decorationColor: Colors.green),),),
              SizedBox(height: 20,),
             Expanded(
               child: StreamBuilder(
                 stream: realtime.onValue,
              
                 builder: (context, snapshot) {
                   Map<dynamic,dynamic>m=snapshot.data!.snapshot.value as dynamic;
                   List<dynamic>list=m.values.toList();
                 return ListView.builder(
                   itemCount: snapshot.data!.snapshot.children.length,
                   itemBuilder: (context,i){
                  return  Text(list[i]['name']);
      
                 });
               },
               ),
             ),
              ElevatedButton(onPressed: (){
                
              }, child: Text("Find Data"))
              // Expanded(
              //   child: list,
              //   // child: FirebaseAnimatedList(query: realtime, itemBuilder: (context,snapshot,animation,index){
              //   //   return ListTile(title: Text("Hello "),trailing: Text(snapshot.child("name").value.toString()),
              //   //   );
              //   // }
              //   //),
              // )
            ]),
        ),),
      )
    );
  }
}
