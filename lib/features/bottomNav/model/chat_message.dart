// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMessages {
  final String senderId;
  final String content;
  final String updatedAt;

  ChatMessages(
      {required this.senderId, required this.content, required this.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'content': content,
      'updatedAt': updatedAt,
    };
  }

  factory ChatMessages.fromMap(Map<String, dynamic> map) {
    return ChatMessages(
      senderId: map['senderId'] as String,
      content: map['content'] as String,
      updatedAt: map['updatedAt'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessages.fromJson(String source) =>
      ChatMessages.fromMap(json.decode(source) as Map<String, dynamic>);
}
