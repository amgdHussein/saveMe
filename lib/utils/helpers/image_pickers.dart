// ignore: missing_return
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> imgFromCamera() async {
  final _picker = ImagePicker();
  final pickedFile = await _picker.getImage(source: ImageSource.camera);
  if (pickedFile != null) return File(pickedFile.path);
}

// ignore: missing_return
Future<File> imgFromGallery() async {
  final _picker = ImagePicker();
  final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  if (pickedFile != null) return File(pickedFile.path);
}
