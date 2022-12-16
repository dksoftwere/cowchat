import 'package:cowchat/constants.dart';
import 'package:cowchat/screen/DashboardScreen.dart';
import 'package:cowchat/screen/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'WalkScreen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState()=>_SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  Future.delayed(const Duration(seconds: 5),() async {
    if (await FirebaseAuth.instance.currentUser!=null){
      Navigator.pushNamedAndRemoveUntil(context,'/home',(route)=>false);
    }else{
      Navigator.pushNamedAndRemoveUntil(context,'/walk',(route)=>false);
    }
   
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CWPrimaryColor,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(50),
        child: Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child:Image.asset('assets/images/first.gif',fit: BoxFit.fill,)
        ),
      ),)
    );
  }
}