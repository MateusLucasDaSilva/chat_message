import 'package:chat_message/app/repositories/users/i_user_repository.dart';
import 'package:chat_message/app/repositories/users/users_repository.dart';
import 'package:chat_message/app/services/chat/chat_service.dart';
import 'package:chat_message/app/services/chat/i_chat_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    Provider<IChatService>(
      create: (context) => ChatService(),
    ),
    Provider<IUserRepository>(
      create: (context) => UsersRepository(),
    ),
  ];
}
