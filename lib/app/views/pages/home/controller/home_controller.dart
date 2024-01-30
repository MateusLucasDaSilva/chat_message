import 'package:chat_message/app/models/user_model.dart';
import 'package:chat_message/app/repositories/users/i_user_repository.dart';
import 'package:chat_message/app/services/chat/i_chat_service.dart';
import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  final IUserRepository _userRepository;
  final IChatService _chatService;

  HomeController({
    required IUserRepository userRepository,
    required IChatService chatService,
  })  : _userRepository = userRepository,
        _chatService = chatService;

  List<UserModel> users = [];
  Map<String, Stream<bool>> listenChatMap = {};

  Future<void> getUsers() async {
    final result = await _userRepository.getUsers();
    _getListeners(result);
    users = result;
    notifyListeners();
  }

  void _getListeners(List<UserModel> result) {
    for (var e in result) {
      final result = _chatService.listenChatRoom(receiverId: e.uid);
      listenChatMap[e.uid] = result;
    }
  }
}
