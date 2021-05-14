import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import '../../../repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final picker = ImagePicker();
  final UserRepository _userRepository =
      UserRepository(firebaseAuth: FirebaseAuth.instance);
  ProfileCubit()
      : super(
          ProfileInitial(
            user: UserRepository(firebaseAuth: FirebaseAuth.instance).getUser(),
          ),
        );

  void updateName({@required String name}) {
    state.user.updateProfile(displayName: name).then((value) {
      emit(UpdatingName(
        user: _userRepository.getUser(),
      ));
    });
  }

  void updatePhoto({@required String url}) {
    deletePhoto(imagePath: state.user.photoURL).then((_) {
      state.user.updateProfile(photoURL: url).then((_) {
        emit(UpdatingPhoto(
          user: _userRepository.getUser(),
        ));
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
                  _image = await _imgFromGallery();
                  if (_image != null) uploadPhoto(imageFile: _image);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  _image = await _imgFromCamera();
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

  // ignore: missing_return
  Future<File> _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) return File(pickedFile.path);
  }

  // ignore: missing_return
  Future<File> _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) return File(pickedFile.path);
  }
}
