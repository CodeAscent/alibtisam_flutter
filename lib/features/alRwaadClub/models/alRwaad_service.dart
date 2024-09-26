// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlRwaadService {
  String? id;
  String? name;
  String? arabicName;
  String? icon;
  String? type;
  dynamic pricing;
  AlRwaadService({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.icon,
    required this.type,
    required this.pricing,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'arabicName': arabicName,
      'icon': icon,
      'type': type,
      'pricing': pricing,
    };
  }

  factory AlRwaadService.fromMap(Map<String, dynamic> map) {
    return AlRwaadService(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      arabicName:
          map['arabicName'] != null ? map['arabicName'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      pricing: map['pricing'] != null ? map['pricing'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlRwaadService.fromJson(String source) =>
      AlRwaadService.fromMap(json.decode(source) as Map<String, dynamic>);
}
