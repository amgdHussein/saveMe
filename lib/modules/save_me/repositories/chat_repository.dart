import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_me/modules/save_me/models/message.dart';

class ChatRepository {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get messages {
    return _firestoreInstance.collection('chats').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userChats(uid) {
    return _firestoreInstance
        .collection('chats')
        .doc(uid)
        .collection('chatwith')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> userChatMessages(uid, sid) {
    return _firestoreInstance
        .collection('chats')
        .doc(uid)
        .collection('chatwith')
        .doc(sid)
        .collection('messages')
        .snapshots();
  }

  Future<void> addMessage(Message message) async {
    DocumentReference<Map<String, dynamic>> _senderRef = _firestoreInstance
        .collection('chats')
        .doc(message.senderId)
        .collection('chatwith')
        .doc(message.reciverId)
        .collection('messages')
        .doc();

    await _senderRef.set(message.toMap());

    DocumentReference<Map<String, dynamic>> _reciverRef = _firestoreInstance
        .collection('chats')
        .doc(message.reciverId)
        .collection('chatwith')
        .doc(message.senderId)
        .collection('messages')
        .doc();

    await _reciverRef.set(message.toMap());
  }

  Future<dynamic> deleteMessage(String uid, String sid, String mid) async {
    return await _firestoreInstance
        .collection('chats')
        .doc(uid)
        .collection('chatwith')
        .doc(sid)
        .collection('messages')
        .doc(mid)
        .delete();
  }
}
