import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:save_me/modules/save_me/models/message.dart';

class ConversationRepository {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> get conversations {
    return _firestoreInstance
        .collection('conversations')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('chats')
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> messages(sid) {
    return _firestoreInstance
        .collection('conversations')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('chats')
        .doc(sid)
        .collection('messages')
        .snapshots();
  }

  Future<void> addMessage(Message message) async {
    DocumentReference<Map<String, dynamic>> _senderRef = _firestoreInstance
        .collection('conversations')
        .doc(message.sid)
        .collection('chats')
        .doc(message.rid)
        .collection('messages')
        .doc();

    await _senderRef.set(message.copyWith(mid: _senderRef.id).toMap());

    DocumentReference<Map<String, dynamic>> _reciverRef = _firestoreInstance
        .collection('conversations')
        .doc(message.rid)
        .collection('chats')
        .doc(message.sid)
        .collection('messages')
        .doc();

    await _reciverRef.set(message.copyWith(mid: _reciverRef.id).toMap());
  }

  Future<dynamic> deleteMessage(String sid, String mid) async {
    return await _firestoreInstance
        .collection('conversations')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('chats')
        .doc(sid)
        .collection('messages')
        .doc(mid)
        .delete();
  }
}
