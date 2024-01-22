import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:chat_message/app/views/pages/init/controller/init_controller.dart';
import 'package:chat_message/app/views/pages/init/init_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InitController>(
          create: (context) => InitController(),
        ),
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'Chat message',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const InitPage(),
      ),
    );
  }
}
