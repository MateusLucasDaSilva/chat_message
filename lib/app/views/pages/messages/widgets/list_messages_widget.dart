import 'package:chat_message/app/models/message_model.dart';
import 'package:chat_message/app/services/chat/i_chat_service.dart';
import 'package:chat_message/app/views/pages/messages/widgets/message_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMessagesWidget extends StatelessWidget {
  final String uidReceiver;
  const ListMessagesWidget({
    super.key,
    required this.uidReceiver,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageModel>>(
      stream: context.read<IChatService>().getMessages(uidReceiver),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Expanded(
            child: Center(
              child: Text('Ocorreu um Erro!'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Expanded(
          child: ListView(
            reverse: true,
            children: snapshot.data!
                .map((e) => MessageItemWidget(message: e))
                .toList(),
          ),
        );
      },
    );
  }
}
