import 'package:chat_message/app/models/message_model.dart';
import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatService extends ChangeNotifier {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('chat_rooms');
  void sendMessage(
    String message,
    String receiverId,
  ) {
    final String senderId = AuthService.instance.user.value!.uid;
    final String senderEmail = AuthService.instance.user.value!.email ?? '';

    final ids = [receiverId, senderId];

    ids.sort();
    String idsRoom = ids.join('_').trim();

    final messageModel = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      email: senderEmail,
      dateTime: DateTime.now(),
    );

    collection.doc(idsRoom).collection('messages').add(messageModel.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String receiverId) {
    final String senderId = AuthService.instance.user.value!.uid;

    final ids = [receiverId, senderId];
    ids.sort();
    String idsRoom = ids.join('_').trim();

    return collection
        .doc(idsRoom)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }
}
