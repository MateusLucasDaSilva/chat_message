import 'package:chat_message/app/models/user_model.dart';
import 'package:chat_message/app/repositories/users/users_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = UsersRepository();

  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    repository.getUsers().then((value) {
      setState(() {
        users = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat de Mensagens'),
      ),
      body: Column(
        children: users
            .map((e) => ListTile(
                  title: Text(e.uid),
                ))
            .toList(),
      ),
    );
  }
}
