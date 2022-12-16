import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier{
  String email="";
  String password="";
  void signIn(String emailText,String passwordText){
    email=emailText;
    password=passwordText;
    notifyListeners();
  }
}
