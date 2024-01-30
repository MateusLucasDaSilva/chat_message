import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailEC,
                  decoration: const InputDecoration(
                    label: Text('email'),
                  ),
                ),
                TextField(
                  controller: passwordEC,
                  decoration: const InputDecoration(
                    label: Text('password'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FilledButton(
                  onPressed: login,
                  child: const Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (passwordEC.text.length < 6 || emailEC.text.isEmpty) {
      return;
    }
    context.read<AuthService>().login(
          emailEC.text,
          passwordEC.text,
        );
  }
}
