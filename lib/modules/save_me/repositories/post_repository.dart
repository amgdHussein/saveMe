import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class PostRepository {
  final _firestoreInstance = FirebaseFirestore.instance;
  // final User _user = FirebaseAuth.instance.currentUser;

  // Future<DocumentSnapshot> getPostOwner() async {
  //   DocumentSnapshot documentSnapshot = await readUserPost();
  // }

  Future<dynamic> post(String pid) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestoreInstance.collection('posts').doc(pid).get();
    Map<String, dynamic> data = doc.data();
    if (data.containsKey('missingFrom')) return Missing.fromMap(data);
    return Finding.fromMap(data);
  }

  Future<void> addPost(dynamic post) async {
    DocumentReference<Map<String, dynamic>> _ref =
        _firestoreInstance.collection('posts').doc();
    Map<String, dynamic> data = post.toMap();
    data['pid'] = _ref.id;
    await _ref.set(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get posts {
    return _firestoreInstance.collection('posts').snapshots();
  }

  Future<void> updatePost(dynamic post) async {
    await _firestoreInstance.collection('posts').doc(post.pid).set(
          post.toMap(),
          SetOptions(merge: true),
        );
  }
}
