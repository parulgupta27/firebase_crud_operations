import 'package:flutter/material.dart';
class StreamList extends StatefulWidget {
  const StreamList({super.key});

  @override
  State<StreamList> createState() => _StreamListState();
}

class _StreamListState extends State<StreamList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(builder: (context,snapshot){
          return  Text(snapshot.data.toString());
        })
      ],
    );
  }
}