import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:chat_message/app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
            children:
                snapshot.data!.docs.map((e) => _buildMessageItem(e)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot documentSnapshot) {
    final Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>;

    final String email = data['email'];
    final String message = data['message'];

    final TextAlign textAlign =
        AuthService.instance.user.value!.uid == data['senderId']
            ? TextAlign.right
            : TextAlign.left;
    return Text(
      '$email \n $message',
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
