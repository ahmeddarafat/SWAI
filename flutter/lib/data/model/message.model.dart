class MessageModel {
  final String text;
  final DateTime sendingTime;
  final bool isMe;

  MessageModel({
    required this.text,
    required this.sendingTime,
    required this.isMe,
  });

  factory MessageModel.fromJosn(Map<String, dynamic> json) {
    return MessageModel(
      text: json["text"],
      sendingTime: json["sendingTime"],
      isMe: json["isMe"],
    );
  }
}
