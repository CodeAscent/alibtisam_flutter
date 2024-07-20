// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GameModel {
  final String name;
  final String id;
  final List<dynamic> stage;

  GameModel(this.name, this.id, this.stage);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'stage': stage,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      map['name'] as String,
      map['_id'] as String,
      map['stage'] ?? map['stage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GameModel.fromJson(String source) =>
      GameModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
