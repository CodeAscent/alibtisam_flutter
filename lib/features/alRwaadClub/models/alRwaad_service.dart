// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlRwaadService {
  String? name;
  String? arabicName;
  String? icon;

  AlRwaadService({
    required this.name,
    required this.arabicName,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'arabicName': arabicName,
      'icon': icon,
    };
  }

  factory AlRwaadService.fromMap(Map<String, dynamic> map) {
    return AlRwaadService(
      name: map['name'] != null ? map['name'] as String : null,
      arabicName:
          map['arabicName'] != null ? map['arabicName'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlRwaadService.fromJson(String source) =>
      AlRwaadService.fromMap(json.decode(source) as Map<String, dynamic>);
}
