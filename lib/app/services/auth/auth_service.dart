import 'package:chat_message/app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final _instance = FirebaseAuth.instance;

  ValueNotifier<UserModel?> user = ValueNotifier<UserModel?>(null);

  void checkUserLogged() {
    final currentUser = _instance.currentUser;
    if (currentUser != null) {
      user.value = UserModel(uid: currentUser.uid, email: currentUser.email);
    }
  }

  Future<void> login(String email, String password) async {
    final UserCredential userCredential = await _instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user != null) {
      user.value = UserModel(
          uid: userCredential.user!.uid, email: userCredential.user?.email);
    }
  }

  Future<void> logout() async {
    await _instance.signOut();
    user.value = null;
  }
}
