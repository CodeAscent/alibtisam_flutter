// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';

class ChatsList {
  final String? id;
  final bool? isGroup;
  final List<UserModel>? participantDetails;
  final String? lastMessage;
  final String? updatedAt;

  ChatsList(
      {required this.id,
      required this.isGroup,
      required this.participantDetails,
      required this.lastMessage,
      required this.updatedAt});

  factory ChatsList.fromMap(Map<String, dynamic> map) {
    return ChatsList(
      isGroup: map['isGroup'] != null ? map['isGroup'] as bool : null,
      participantDetails: map['participantDetails'] != null
          ? List<UserModel>.from(
              (map['participantDetails']).map<UserModel?>(
                (x) => UserModel.fromMap(x),
              ),
            )
          : null,
      lastMessage:
          map['lastMessage'] != null ? map['lastMessage'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      id: map['_id'],
    );
  }

  factory ChatsList.fromJson(String source) =>
      ChatsList.fromMap(json.decode(source) as Map<String, dynamic>);
}
