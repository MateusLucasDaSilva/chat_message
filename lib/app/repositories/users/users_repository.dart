import 'package:chat_message/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersRepository {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<List<UserModel>> getUsers() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> result =
          await _instance.collection('users').get();

      final List<UserModel> listUsers =
          result.docs.map((user) => UserModel.fromJson(user.data())).toList();

      return listUsers;
    } catch (e) {
      rethrow;
    }
  }
}
