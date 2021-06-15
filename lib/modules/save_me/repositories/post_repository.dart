import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import 'face_recognition_repository.dart';

class PostRepository {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  final FaceRecognitionRepository _faceRecognitionRepository =
      FaceRecognitionRepository();

  Future<dynamic> post(String pid) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestoreInstance.collection('posts').doc(pid).get();
    Map<String, dynamic> data = doc.data();
    if (data.containsKey('missingFrom')) return Missing.fromMap(data);
    return Finding.fromMap(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get posts {
    return _firestoreInstance.collection('posts').snapshots();
  }

  Future<void> addPost(dynamic post) async {
    DocumentReference<Map<String, dynamic>> _ref =
        _firestoreInstance.collection('posts').doc();

    // add image -> face recognition repository
    Map<String, dynamic> data = post.toMap();
    data['pid'] = _ref.id;
    data = await updateImage(map: data);

    await _ref.set(data);
  }

  Future<Map<String, dynamic>> updateImage({Map<String, dynamic> map}) async {
    String link = await _faceRecognitionRepository.addImage(
      pid: map['pid'],
      imagePath: map['image'],
    );
    map['image'] = link;

    return map;
  }

  Future<void> updatePost(dynamic post) async {
    Map<String, dynamic> data = await updateImage(map: post.toMap());
    await _firestoreInstance.collection('posts').doc(post.pid).set(
          data,
          SetOptions(merge: true),
        );
  }

  // deletePost
}
