import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_me/constants/assest_path.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({@required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> singInWithCredentials({
    @required String email,
    @required String password,
  }) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  Future<void> singUpWithCredentials({
    @required String email,
    @required String password,
    @required String userName,
  }) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _firebaseAuth.currentUser.reload();
    await _firebaseAuth.currentUser.updateProfile(
      displayName: userName,
      photoURL: defaultPhotoURL,
    );
    return user;
  }

  Future<void> singOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  User getUser() {
    return _firebaseAuth.currentUser;
  }
}
