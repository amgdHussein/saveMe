import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message.dart';

class ConversationRepository {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get conversations {
    return _firestoreInstance
        .collection('conversations')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('chats')
        .snapshots();
  }

  Future<void> setChatId(String sid, String rid) async {
    await _firestoreInstance
        .collection('conversations')
        .doc(sid)
        .set({'uid': sid});

    await _firestoreInstance
        .collection('conversations')
        .doc(rid)
        .set({'uid': rid});
  }

  Future<void> setConversationId(String sid, String rid) async {
    await _firestoreInstance
        .collection('conversations')
        .doc(sid)
        .collection('chats')
        .doc(rid)
        .set({'uid': rid});

    await _firestoreInstance
        .collection('conversations')
        .doc(rid)
        .collection('chats')
        .doc(sid)
        .set({'uid': sid});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> messages(String sid) {
    return _firestoreInstance
        .collection('conversations')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('chats')
        .doc(sid)
        .collection('messages')
        .orderBy("date", descending: true)
        .snapshots();
  }

  Future<void> addMessage(Message message) async {
    await setConversationId(message.sid, message.rid);
    await setChatId(message.sid, message.rid);

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

  Future<void> deleteMessage(String sid) async {
    CollectionReference<Map<String, dynamic>> chatsReferences =
        _firestoreInstance
            .collection('conversations')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection('chats');

    CollectionReference<Map<String, dynamic>> messagesReferences =
        chatsReferences.doc(sid).collection('messages');

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await messagesReferences.get();

    snapshot.docs.forEach((element) async {
      await messagesReferences.doc(element.id).delete();
    });

    await chatsReferences.doc(sid).delete();
  }
}
