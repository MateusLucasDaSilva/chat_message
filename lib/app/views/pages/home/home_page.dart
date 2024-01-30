import 'package:chat_message/app/models/user_model.dart';
import 'package:chat_message/app/repositories/users/users_repository.dart';
import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:chat_message/app/services/chat/chat_service.dart';
import 'package:chat_message/app/views/pages/home/widgets/user_tile_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = UsersRepository();
  final ChatService chat = ChatService();

  List<UserModel> users = [];
  Map<String, Stream<bool>> listenChatMap = {};

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    final result = await repository.getUsers();
    getListeners(result);
    setState(() {
      users = result;
    });
  }

  void getListeners(List<UserModel> result) {
    for (var e in result) {
      final result = chat.listenChat(receiverId: e.uid);
      listenChatMap[e.uid] = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat de Mensagens'),
        actions: [
          IconButton(
              onPressed: () => AuthService.instance.logout(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => UserTileWidget(
          listenChatMap: listenChatMap,
          user: users[index],
        ),
      ),
    );
  }
}
