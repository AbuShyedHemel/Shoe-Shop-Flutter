import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String getUserID() {
    return _firebaseAuth.currentUser!.uid;
  }

  final CollectionReference productRef =
      FirebaseFirestore.instance.collection('Products');
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');
}
