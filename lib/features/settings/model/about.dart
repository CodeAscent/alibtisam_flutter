import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class About {
  String id;
  String name;
  String foundedOn;
  String founder;
  String location;
  String mission;
  String vision;
  String description;
  String registrationNumber;
  String logo;
  String banner;
  String superAdminId;
  bool disabled;
  List<dynamic> socialAccount;
  String createdAt;
  String updatedAt;
  About({
    required this.id,
    required this.name,
    required this.foundedOn,
    required this.founder,
    required this.location,
    required this.mission,
    required this.vision,
    required this.description,
    required this.registrationNumber,
    required this.logo,
    required this.banner,
    required this.superAdminId,
    required this.disabled,
    required this.socialAccount,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'foundedOn': foundedOn,
      'founder': founder,
      'location': location,
      'mission': mission,
      'vision': vision,
      'description': description,
      'registrationNumber': registrationNumber,
      'logo': logo,
      'banner': banner,
      'superAdminId': superAdminId,
      'disabled': disabled,
      'socialAccount': socialAccount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory About.fromMap(Map<String, dynamic> map) {
    return About(
      id: map['_id'] as String,
      name: map['name'] as String,
      foundedOn: map['foundedOn'] as String,
      founder: map['founder'] as String,
      location: map['location'] as String,
      mission: map['mission'] as String,
      vision: map['vision'] as String,
      description: map['description'] as String,
      registrationNumber: map['registrationNumber'] as String,
      logo: map['logo'] as String,
      banner: map['banner'] as String,
      superAdminId: map['superAdminId'] as String,
      disabled: map['disabled'] as bool,
      socialAccount: List<dynamic>.from(map['socialAccount'] as List<dynamic>),
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory About.fromJson(String source) =>
      About.fromMap(json.decode(source) as Map<String, dynamic>);
}
