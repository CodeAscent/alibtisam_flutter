// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMessages {
  String? senderId;
  String? content;
  String? updatedAt;
  String? message;
  String? mediaUrl;
  String? type;
  ChatMessages({
    this.senderId,
    this.content,
    this.updatedAt,
    this.message,
    this.mediaUrl,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'content': content,
      'updatedAt': updatedAt,
      'message': message,
      'mediaUrl': mediaUrl,
      'type': type,
    };
  }

  factory ChatMessages.fromMap(Map<String, dynamic> map) {
    return ChatMessages(
      senderId: map['senderId'] != null ? map['senderId'] as String : '',
      content: map['content'] != null ? map['content'] as String : '',
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : '',
      message: map['message'] != null ? map['message'] as String : '',
      mediaUrl: map['mediaUrl'] != null ? map['mediaUrl'] as String : '',
      type: map['type'] != null ? map['type'] as String : 'text',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessages.fromJson(String source) =>
      ChatMessages.fromMap(json.decode(source) as Map<String, dynamic>);
}
