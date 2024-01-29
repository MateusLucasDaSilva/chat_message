import 'package:chat_message/app/models/message_model.dart';
import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:chat_message/app/services/chat/chat_service.dart';
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
            _buildMessagesWidget(),
            _buildInputWidget(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesWidget() {
    return StreamBuilder<List<MessageModel>>(
      stream: context.read<ChatService>().getMessages(widget.uidReceiver),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Ocorreu um Erro!');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return Expanded(
          child: ListView(
            reverse: true,
            children: snapshot.data!.map((e) => _buildMessageItem(e)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildMessageItem(MessageModel message) {
    final TextAlign textAlign =
        AuthService.instance.user.value!.uid == message.senderId
            ? TextAlign.right
            : TextAlign.left;
    return Text(
      '${message.email} \n ${message.message}',
      textAlign: textAlign,
    );
  }

  Widget _buildInputWidget() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: inputEC,
          ),
        ),
        IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send_sharp))
      ],
    );
  }

  void _sendMessage() {
    if (inputEC.text.isEmpty) return;
    context.read<ChatService>().sendMessage(inputEC.text, widget.uidReceiver);
    inputEC.clear();
  }
}
