// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String userName;
  final String email;
  final String pic;
  final String role;
  final String mobile;
  final String name;

  UserModel(
    this.userName,
    this.email,
    this.pic,
    this.role,
    this.mobile,
    this.name,
  );

  UserModel copyWith({
    String? userName,
    String? email,
    String? pic,
    String? role,
    String? mobile,
    String? name,
  }) {
    return UserModel(
      userName ?? this.userName,
      email ?? this.email,
      pic ?? this.pic,
      role ?? this.role,
      mobile ?? this.mobile,
      name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'email': email,
      'pic': pic,
      'role': role,
      'mobile': mobile,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['userName'] as String,
      map['email'] as String,
      map['pic'] as String,
      map['role'] as String,
      map['mobile'] as String,
      map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userName: $userName, email: $email, pic: $pic, role: $role, mobile: $mobile, name: $name)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.email == email &&
        other.pic == pic &&
        other.role == role &&
        other.mobile == mobile &&
        other.name == name;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        email.hashCode ^
        pic.hashCode ^
        role.hashCode ^
        mobile.hashCode ^
        name.hashCode;
  }
}
