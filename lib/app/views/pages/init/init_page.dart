import 'package:chat_message/app/models/user_model.dart';
import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:chat_message/app/views/pages/auth/login/login_page.dart';
import 'package:chat_message/app/views/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() {
    AuthService.instance.checkUserLogged();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserModel?>(
      valueListenable: AuthService.instance.user,
      builder: (context, value, child) {
        if (value != null) {
          return const HomePage();
        }
        return const LoginPage();
      },
    );
  }
}
