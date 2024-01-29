// ignore_for_file: public_member_api_docs, sort_constructors_first

class MessageModel {
  final String? uid;
  final String senderId;
  final String receiverId;
  final String message;
  final String email;
  final DateTime dateTime;
  final bool viewedByReceiver;
  MessageModel({
    this.uid,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.email,
    required this.dateTime,
    required this.viewedByReceiver,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'email': email,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'viewedByReceiver': viewedByReceiver,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map, String uid) {
    return MessageModel(
      uid: uid,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      email: map['email'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      viewedByReceiver: map['viewedByReceiver'] as bool,
    );
  }
}
