import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClubSport {
  final String? id;
  final String? name;
  final String? arabicName;
  final String? icon;
  final List<dynamic>? stage;
  final List<AgeCategory>? ageCategoryIds;

  ClubSport(this.id, this.name, this.arabicName, this.icon, this.stage,
      this.ageCategoryIds);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'arabicName': arabicName,
      'icon': icon,
      'stage': stage,
      'ageCategoryIds': ageCategoryIds,
    };
  }

  factory ClubSport.fromMap(Map<String, dynamic> map) {
    return ClubSport(
      map['_id'] != null ? map['_id'] as String : null,
      map['name'] != null ? map['name'] as String : null,
      map['arabicName'] != null ? map['arabicName'] as String : null,
      map['icon'] != null ? map['icon'] as String : null,
      map['stage'] != null
          ? List<dynamic>.from(map['stage'] as List<dynamic>)
          : null,
      map['ageCategoryIds'] != null
          ? List<AgeCategory>.from(
              (map['ageCategoryIds']).map<AgeCategory?>(
                (x) => AgeCategory.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClubSport.fromJson(String source) =>
      ClubSport.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AgeCategory {
  String? id;
  String? name;
  num? minAge;
  num? maxAge;
  AgeCategory({
    this.id,
    this.name,
    this.minAge,
    this.maxAge,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'minAge': minAge,
      'maxAge': maxAge,
    };
  }

  factory AgeCategory.fromMap(Map<String, dynamic> map) {
    return AgeCategory(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      minAge: map['minAge'] != null ? map['minAge'] as num : null,
      maxAge: map['maxAge'] != null ? map['maxAge'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgeCategory.fromJson(String source) =>
      AgeCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
