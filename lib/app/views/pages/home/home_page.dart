import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:chat_message/app/views/pages/home/controller/home_controller.dart';
import 'package:chat_message/app/views/pages/home/widgets/user_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<HomeController>();
    _controller.getUsers();
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
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) => ListView.builder(
          itemCount: _controller.users.length,
          itemBuilder: (context, index) => UserTileWidget(
            listenChatMap: _controller.listenChatMap,
            user: _controller.users[index],
          ),
        ),
      ),
    );
  }
}
