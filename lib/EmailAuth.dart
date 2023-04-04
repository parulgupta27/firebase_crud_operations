import 'package:crud/FetchFireStore.dart';
import 'package:crud/imageUpload.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
class EmailSignUp extends StatefulWidget {
  const EmailSignUp({super.key});

  @override
  State<EmailSignUp> createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  @override
  var email=TextEditingController();
  var pass=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      TextField(
        controller: email,
        decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1)))),
      SizedBox(height: 20,),
      TextField(
        controller: pass,
        decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1)))),
    SizedBox(height: 10,),
    OutlinedButton(onPressed: ()async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: pass.text).then((value) => {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FetchFireStore())),
    }).onError((error, stackTrace) => {
    });
    }, child: Text("Register"),),
    ])
    ,);
  }
}