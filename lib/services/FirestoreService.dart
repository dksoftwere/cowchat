import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
  FirebaseFirestore.instance.collection("users");

  Future createUser(User user) async{
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e;
    }
  }

  Future getUser(String userId) async{
    try {
     return await _usersCollectionReference.doc(userId).get();
    } catch (e) {
      return e;
    }
  }
}