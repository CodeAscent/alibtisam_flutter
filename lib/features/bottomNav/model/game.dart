// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GameModel {
  final String? name;
  final String? id;
  final List<dynamic>? stage;
  final String icon;

  GameModel(this.name, this.id, this.stage, this.icon);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'stage': stage,
      'icon': icon,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      map['name'] != null ? map['name'] as String : null,
      map['_id'] != null ? map['_id'] as String : null,
      map['stage'] != null ? map['stage'] : null,
      map['icon'] != null ? map['icon'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameModel.fromJson(String source) =>
      GameModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
