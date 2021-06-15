import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/firestore_user.dart';

class UserRepository {
  final _firestoreInstance = FirebaseFirestore.instance;

  Future<FirestoreUser> user(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestoreInstance.collection('users').doc(uid).get();
    return FirestoreUser.fromMap(doc.data());
  }

  Future<void> addUser(User user) async {
    return await _firestoreInstance
        .collection('users')
        .doc(user.uid)
        .set(FirestoreUser.fromFirebaseUser(user).toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get users {
    return _firestoreInstance.collection('users').snapshots();
  }

  Future<void> updateUser(User user) async {
    return await _firestoreInstance.collection('users').doc(user.uid).set(
          FirestoreUser.fromFirebaseUser(user).toMap(),
          SetOptions(merge: true),
        );
  }

  Future<void> deleteUser(String uid) async {
    return await _firestoreInstance.collection('users').doc(uid).delete();
  }
}
