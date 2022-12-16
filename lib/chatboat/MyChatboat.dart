import 'package:cowchat/chatboat/Chat.dart';
import 'package:cowchat/constants.dart';
import 'package:flutter/material.dart';

class MyChatboat extends StatefulWidget {
  const MyChatboat({super.key});

  @override
  _MyChatboatState createState() => _MyChatboatState();
}

class _MyChatboatState extends State<MyChatboat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dinesh chatboat",style:TextStyle(color: CWPrimaryColor,fontSize: 18),),
          elevation: 0.3,
        ),
        body: const Center(
            child: Chat())
    );
  }
}