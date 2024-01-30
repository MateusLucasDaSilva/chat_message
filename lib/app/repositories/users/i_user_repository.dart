import 'package:chat_message/app/models/user_model.dart';

abstract class IUserRepository {
  Future<List<UserModel>> getUsers();
}
