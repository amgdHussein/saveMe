import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_me/modules/save_me/repositories/user_repository.dart';
import '../../../constants/assest_path.dart';

class UserAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final UserRepository _userRepo = UserRepository();

  UserAuthRepository({@required FirebaseAuth firebaseAuth})
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
    await _firebaseAuth.currentUser.updateDisplayName(userName);
    await _firebaseAuth.currentUser.updatePhotoURL(defaultPhotoURL);
    await _userRepo.addUser(_firebaseAuth.currentUser);
    return user;
  }

  Future<void> singOut() async {
    return await _firebaseAuth.signOut();
  }

  User get user => _firebaseAuth.currentUser;

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }
}
