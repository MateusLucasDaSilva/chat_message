import 'package:chat_message/app/services/chat/chat_service.dart';
import 'package:chat_message/app/views/pages/messages/widgets/input_message_widget.dart';
import 'package:chat_message/app/views/pages/messages/widgets/list_messages_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  final String email;
  final String uidReceiver;

  const MessagesPage(
      {super.key, required this.email, required this.uidReceiver});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final inputEC = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    inputEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.email),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListMessagesWidget(uidReceiver: widget.uidReceiver),
            InputMessageWidget(
              onTapSend: _sendMessage,
              textEditingController: inputEC,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (inputEC.text.isEmpty) return;
    context.read<ChatService>().sendMessage(inputEC.text, widget.uidReceiver);
    inputEC.clear();
  }
}
