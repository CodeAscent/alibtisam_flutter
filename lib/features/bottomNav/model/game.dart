// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GameModel {
  final String name;
  final String id;
  final String icon;
  final String stage;

  GameModel(this.name, this.id, this.icon, this.stage);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'icon': icon,
      'stage': stage,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      map['name'] as String,
      map['_id'] as String,
      map['icon'] as String,
      map['stage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameModel.fromJson(String source) =>
      GameModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
