import 'package:chat_message/app/models/message_model.dart';

abstract class IChatService {
  void sendMessage(
    String message,
    String receiverId,
  );
  Stream<List<MessageModel>> getMessages(String receiverId);

  Stream<bool> listenChatRoom({required String receiverId});
}
