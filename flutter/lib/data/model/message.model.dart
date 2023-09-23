import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String text;
  final DateTime sendingTime;
  final bool isUserSender;

  MessageModel({
    required this.text,
    required this.sendingTime,
    required this.isUserSender,
  });

  factory MessageModel.fromJosn(Map<String, dynamic> json) {
    return MessageModel(
      text: json["text"],
      sendingTime: DateTime.parse(
          (json["sending-date"] as Timestamp).toDate().toString()),
      isUserSender: json["is-user-sender"],
    );
  }
}

class MessageLineModel {
  final String text;
  final bool isMe;

  MessageLineModel({
    required this.text,
    required this.isMe,
  });

  factory MessageLineModel.fromJosn(Map<String, dynamic> json) {
    return MessageLineModel(
      text: json["text"],
      isMe: json["is-user-sender"],
    );
  }
}
