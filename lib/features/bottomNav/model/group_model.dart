// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GroupModel {
  final String? name;
  final String? stage;
  final String? id;
  final int? totalMembers;

  GroupModel(this.name, this.stage, this.id, this.totalMembers);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'stage': stage,
      'id': id,
      'totalMembers': totalMembers,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      map['name'] != null ? map['name'] as String : null,
      map['stage'] != null ? map['stage'] as String : null,
      map['_id'] != null ? map['_id'] as String : null,
      map['totalMembers'] != null ? map['totalMembers'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
