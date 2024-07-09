// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AgeCategoryModel {
  final String id;
  final String name;
  final num minAge;
  final num maxAge;

  AgeCategoryModel(
      {required this.id,
      required this.name,
      required this.minAge,
      required this.maxAge});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'minAge': minAge,
      'maxAge': maxAge,
    };
  }

  factory AgeCategoryModel.fromMap(Map<String, dynamic> map) {
    return AgeCategoryModel(
      id: map['_id'] as String,
      name: map['name'] ?? '??',
      minAge: map['minAge'] as num,
      maxAge: map['maxAge'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgeCategoryModel.fromJson(String source) =>
      AgeCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
