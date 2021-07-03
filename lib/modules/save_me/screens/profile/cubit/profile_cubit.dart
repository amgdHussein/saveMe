import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../../utils/helpers/image_pickers.dart';
import '../../../repositories/user_auth_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  // ignore: unused_field
  final UserAuthRepository _userRepository =
      UserAuthRepository(firebaseAuth: FirebaseAuth.instance);
  ProfileCubit()
      : super(ProfileInitial(user: FirebaseAuth.instance.currentUser));

  void updateName({@required String name}) {
    state.user.updateDisplayName(name).then((value) {
      emit(UpdatingName(user: FirebaseAuth.instance.currentUser));
    });
  }

  void updatePhoto({@required String url}) {
    deletePhoto(imagePath: state.user.photoURL).then((_) {
      state.user.updatePhotoURL(url).then((_) {
        emit(UpdatingPhoto(user: FirebaseAuth.instance.currentUser));
      });
    });
  }

  Future<void> uploadPhoto({@required File imageFile}) async {
    emit(UploadingPhoto(user: state.user));
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageFile.path).pathSegments.last}')
        .putFile(imageFile)
        .then((task) {
      task.ref.getDownloadURL().then((fileURL) => updatePhoto(url: fileURL));
    });
  }

  Future<void> deletePhoto({@required String imagePath}) async {
    String filePath = imagePath.replaceAll(
      RegExp(
        r'https://firebasestorage.googleapis.com/v0/b/save-me-73f14.appspot.com/o/',
      ),
      '',
    );
    filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');
    filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');

    await FirebaseStorage.instance.ref().child(filePath).delete();
  }

  void showPicker(context) {
    File _image;
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () async {
                  _image = File(await imgFromGallery());
                  if (_image != null) uploadPhoto(imageFile: _image);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  _image = File(await imgFromCamera());
                  if (_image != null) uploadPhoto(imageFile: _image);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
