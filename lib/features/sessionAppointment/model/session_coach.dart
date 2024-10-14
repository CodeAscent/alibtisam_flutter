import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SessionCoach {
  String? name;
  String? id;
  SessionCoach({
    this.name,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory SessionCoach.fromMap(Map<String, dynamic> map) {
    return SessionCoach(
      name: map['name'] != null ? map['name'] as String : '',
      id: map['_id'] != null ? map['_id'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionCoach.fromJson(String source) =>
      SessionCoach.fromMap(json.decode(source) as Map<String, dynamic>);
}
