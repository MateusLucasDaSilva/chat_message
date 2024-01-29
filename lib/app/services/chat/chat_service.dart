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
      viewedByReceiver: false,
    );

    collection.doc(idsRoom).collection('messages').add(messageModel.toMap());
  }

  Stream<List<MessageModel>> getMessages(String receiverId) {
    final String senderId = AuthService.instance.user.value!.uid;

    final ids = [receiverId, senderId];
    ids.sort();
    String idsRoom = ids.join('_').trim();

    return collection
        .doc(idsRoom)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .asyncMap((event) {
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = event.docs;
      List<MessageModel> messages = [];
      for (var doc in docs) {
        messages.add(MessageModel.fromMap(doc.data(), doc.id));
      }
      _updateLastMessageViewed(messageOtherUser: messages.first);
      return messages;
    });
  }

  void _updateLastMessageViewed({required MessageModel messageOtherUser}) {
    final String myId = AuthService.instance.user.value!.uid;
    if (messageOtherUser.senderId == myId) {
      return;
    }

    final ids = [messageOtherUser.senderId, myId];
    ids.sort();
    String idsRoom = ids.join('_').trim();
    collection
        .doc(idsRoom)
        .collection('messages')
        .doc(messageOtherUser.uid!)
        .update({
      'viewedByReceiver': true,
    });
  }

  Stream<bool> listenChat({required String receiverId}) {
    try {
      final String senderId = AuthService.instance.user.value!.uid;

      final ids = [receiverId, senderId];
      ids.sort();
      String idsRoom = ids.join('_').trim();
      return collection
          .doc(idsRoom)
          .collection('messages')
          .orderBy('dateTime', descending: true)
          .snapshots()
          .asyncMap((event) {
        final lastMessage = event.docs.first;

        final Map<String, dynamic> data = lastMessage.data();
        if (data['senderId'] == senderId) {
          return false;
        }

        if (data['viewedByReceiver'] == null) {
          return false;
        }

        if (data['viewedByReceiver'] == false) {
          return true;
        }

        return false;
      });
    } catch (e) {
      rethrow;
    }
  }
}
