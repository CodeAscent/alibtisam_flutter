// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/enrollment/models/user.dart';

class Chat {
  final String? id;
  final String? name;
  final String? profilePic;
  final bool? isGroup;
  final List<UserModel>? participants;
  final String? lastMessage;
  final String? updatedAt;

  Chat(this.id, this.name, this.profilePic, this.isGroup, this.participants,
      this.lastMessage, this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'profilePic': profilePic,
      'isGroup': isGroup,
      'participants': participants!.map((x) => x.toMap()).toList(),
      'lastMessage': lastMessage,
      'updatedAt': updatedAt,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      map['_id'] ?? '',
      map['name'] ?? '',
      map['profilePic'] ?? '',
      map['isGroup'] ?? false,
      List.from(
        (map['participants']).map(
          (x) => UserModel.fromMap(x),
        ),
      ),
      map['lastMessage'] ?? '',
      map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);
}
