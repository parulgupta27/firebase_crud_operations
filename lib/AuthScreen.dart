import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    var pn=TextEditingController();
    var pass=TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextField(
            controller: pn,
            decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
          ),
          TextField(
            controller: pass,
            decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
          ),
          OutlinedButton(onPressed: (){
          var auth=FirebaseAuth.instance;
          auth.verifyPhoneNumber(
            phoneNumber: pn.text,
            verificationCompleted: (cred){
            
            }, verificationFailed: (e){
             print(e);
            }, codeSent: (id,token)async{
              final cred=PhoneAuthProvider.credential(smsCode: pass.text,verificationId: id);
              await auth.signInWithCredential(cred).then((value){
                print("done");
              }).onError((error,st){print(error);});

            }, codeAutoRetrievalTimeout: (e){
              print(e);
            });
          }, child:Text("Register"))
        ]),
      ),
    ) ;
  }
}