import 'package:flutter/material.dart';

class SignalNewMessageWidget extends StatelessWidget {
  final Map<String, Stream<bool>> listenChatMap;
  final String userUid;
  const SignalNewMessageWidget({
    super.key,
    required this.listenChatMap,
    required this.userUid,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: listenChatMap[userUid],
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!) {
            return Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(400), color: Colors.red),
            );
          }
          return const SizedBox();
        });
  }
}
