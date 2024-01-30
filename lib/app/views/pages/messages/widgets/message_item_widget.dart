import 'package:chat_message/app/models/message_model.dart';
import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MessageItemWidget extends StatelessWidget {
  final MessageModel message;
  const MessageItemWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isSender = AuthService.instance.user.value!.uid == message.senderId;

    const TextAlign textAlign = TextAlign.left;

    final CrossAxisAlignment crossAxisAlignment =
        isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          message.email,
          textAlign: textAlign,
        ),
        Container(
          margin: EdgeInsets.only(
              left: isSender ? 40 : 0, right: isSender ? 0 : 40),
          decoration: BoxDecoration(
              color: isSender ? Colors.amber[200] : Colors.blueGrey[200],
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              message.message,
              textAlign: textAlign,
            ),
          ),
        ),
      ],
    );
  }
}
