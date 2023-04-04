import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  File? filepath;
  var storage=FirebaseStorage.instance;
   getImage() async{
  final img= await ImagePicker().pickImage(source: ImageSource.gallery);
  if(img!=null){
  filepath=File(img.path);
  }
  else{
    print("Image Not Picked");
  }
  setState(() {
    
  });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: getImage,
            child: Container(
              height: 300,
              width: 300,
              child: Center(child: (filepath==null)?Icon(Icons.image):Image.file(filepath!.absolute),
            ),),
          ),
           OutlinedButton(onPressed: ()async{
           var ref=storage.ref("/profilepic");
           var ut=await ref.putFile(filepath!.absolute);
           await Future.value(ut);
           var url= await ref.getDownloadURL();
           print(url);
           }, child: Text("Upload"),),
        ],
        )),
    );
  }
}