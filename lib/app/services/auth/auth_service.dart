import 'package:chat_message/app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static AuthService? _instance;

  AuthService._();
  static AuthService get instance => _instance ??= AuthService._();

  final _firebase = FirebaseAuth.instance;

  ValueNotifier<UserModel?> user = ValueNotifier<UserModel?>(null);

  void checkUserLogged() {
    final currentUser = _firebase.currentUser;
    if (currentUser != null) {
      user.value = UserModel(uid: currentUser.uid, email: currentUser.email);
    }
  }

  Future<void> login(String email, String password) async {
    final UserCredential userCredential = await _firebase
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user != null) {
      user.value = UserModel(
          uid: userCredential.user!.uid, email: userCredential.user?.email);
    }
  }

  Future<void> logout() async {
    await _firebase.signOut();
    user.value = null;
  }
}
