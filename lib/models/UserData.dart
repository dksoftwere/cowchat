import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  String id;
  String email;
  String password;
  String name;
  UserData({required this.id,required this.email,required this.password,required this.name});

  DocumentReference get fireStoreRef=>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveInfo()async{
    await fireStoreRef.set(toMap());
  }
  Map<String ,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
    };
  }
}