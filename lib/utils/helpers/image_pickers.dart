// ignore: missing_return
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<String> imgFromCamera() async {
  final _picker = ImagePicker();
  final pickedFile = await _picker.getImage(source: ImageSource.camera);
  if (pickedFile != null) return pickedFile.path;
}

// ignore: missing_return
Future<String> imgFromGallery() async {
  final _picker = ImagePicker();
  final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  if (pickedFile != null) return pickedFile.path;
}
