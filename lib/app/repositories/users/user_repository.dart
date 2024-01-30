import 'package:chat_message/app/models/user_model.dart';
import 'package:chat_message/app/repositories/users/i_user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository implements IUserRepository {
  final CollectionReference<Map<String, dynamic>> _collectionUsers =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> result =
          await _collectionUsers.get();
      final List<UserModel> listUsers = [];

      for (var doc in result.docs) {
        final data = doc.data();
        listUsers.add(UserModel.fromMap(data));
      }

      return listUsers;
    } catch (e) {
      rethrow;
    }
  }
}
