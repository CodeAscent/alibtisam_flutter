// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String role;
  final String pic;
  final String gender;
  final String userName;
  final String mobile;

  UserModel(
    this.id,
    this.name,
    this.role,
    this.pic,
    this.gender,
    this.userName,
    this.mobile,
  );

  UserModel copyWith({
    String? id,
    String? name,
    String? role,
    String? pic,
    String? gender,
    String? userName,
    String? mobile,
  }) {
    return UserModel(
      id ?? this.id,
      name ?? this.name,
      role ?? this.role,
      pic ?? this.pic,
      gender ?? this.gender,
      userName ?? this.userName,
      mobile ?? this.mobile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'pic': pic,
      'gender': gender,
      'userName': userName,
      'mobile': mobile,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['_id'] as String,
      map['name'] as String,
      map['role'] as String,
      map['pic'] as String,
      map['gender'] as String,
      map['userName'] as String,
      map['mobile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, role: $role, pic: $pic, gender: $gender, userName: $userName, mobile: $mobile)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.role == role &&
        other.pic == pic &&
        other.gender == gender &&
        other.userName == userName &&
        other.mobile == mobile;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        role.hashCode ^
        pic.hashCode ^
        gender.hashCode ^
        userName.hashCode ^
        mobile.hashCode;
  }
}
