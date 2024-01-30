import 'package:chat_message/app/models/user_model.dart';
import 'package:chat_message/app/services/auth/auth_service.dart';
import 'package:chat_message/app/views/pages/home/widgets/signal_new_message_widget.dart';
import 'package:chat_message/app/views/pages/messages/messages_page.dart';
import 'package:flutter/material.dart';

class UserTileWidget extends StatelessWidget {
  final UserModel user;
  final Map<String, Stream<bool>> listenChatMap;
  const UserTileWidget(
      {super.key, required this.user, required this.listenChatMap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(
        _buildEmail(),
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(),
      ),
      onTap: () => _goToMessages(context),
      trailing: listenChatMap[user.uid] != null
          ? SignalNewMessageWidget(
              listenChatMap: listenChatMap,
              userUid: user.uid,
            )
          : null,
    );
  }

  String _buildEmail() {
    return user.uid == AuthService.instance.user.value!.uid
        ? '${user.email} (Eu)'
        : user.email ?? '';
  }

  void _goToMessages(
    BuildContext context,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MessagesPage(email: user.email ?? '', uidReceiver: user.uid),
      ),
    );
  }
}
