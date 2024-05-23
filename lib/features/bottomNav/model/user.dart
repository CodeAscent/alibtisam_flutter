// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String pic;
  final String gender;
  final String userName;
  final String mobile;
  final String dateOfBirth;
  final String bloodGroup;
  final String fatherName;
  final String motherName;
  final String gameId;
  final String city;
  final String state;
  final String country;
  final String? guardianId;
  final String idFrontImage;
  final String idBackImage;
  final String certificateLink;
  final num height;
  final num weight;
  final String address;
  final bool isActive;
  final Map<String, dynamic> requests;

  UserModel(
    this.id,
    this.name,
    this.email,
    this.role,
    this.pic,
    this.gender,
    this.userName,
    this.mobile,
    this.dateOfBirth,
    this.bloodGroup,
    this.fatherName,
    this.gameId,
    this.city,
    this.state,
    this.country,
    this.guardianId,
    this.idFrontImage,
    this.idBackImage,
    this.certificateLink,
    this.height,
    this.weight,
    this.address,
    this.isActive,
    this.requests,
    this.motherName,
  );

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? pic,
    String? gender,
    String? userName,
    String? mobile,
    String? dateOfBirth,
    String? bloodGroup,
    String? fatherName,
    String? motherName,
    String? gameId,
    String? city,
    String? state,
    String? country,
    String? guardianId,
    String? idFrontImage,
    String? idBackImage,
    String? certificateLink,
    num? height,
    num? weight,
    String? address,
    bool? isActive,
    Map<String, dynamic>? requests,
  }) {
    return UserModel(
        id ?? this.id,
        name ?? this.name,
        email ?? this.email,
        role ?? this.role,
        pic ?? this.pic,
        gender ?? this.gender,
        userName ?? this.userName,
        mobile ?? this.mobile,
        dateOfBirth ?? this.dateOfBirth,
        bloodGroup ?? this.bloodGroup,
        fatherName ?? this.fatherName,
        gameId ?? this.gameId,
        city ?? this.city,
        state ?? this.state,
        country ?? this.country,
        guardianId ?? this.guardianId,
        idFrontImage ?? this.idFrontImage,
        idBackImage ?? this.idBackImage,
        certificateLink ?? this.certificateLink,
        height ?? this.height,
        weight ?? this.weight,
        address ?? this.address,
        isActive ?? this.isActive,
        requests ?? this.requests,
        motherName ?? this.motherName);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'pic': pic,
      'gender': gender,
      'userName': userName,
      'mobile': mobile,
      'dateOfBirth': dateOfBirth,
      'bloodGroup': bloodGroup,
      'fatherName': fatherName,
      'gameId': gameId,
      'city': city,
      'state': state,
      'country': country,
      'guardianId': guardianId,
      'idFrontImage': idFrontImage,
      'idBackImage': idBackImage,
      'certificateLink': certificateLink,
      'height': height,
      'weight': weight,
      'address': address,
      'isActive': isActive,
      'requests': requests,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        map['_id'] ?? '',
        map['name'] ?? '',
        map['email'] ?? '',
        map['role'] ?? '',
        map['pic'] ?? '',
        map['gender'] ?? '',
        map['userName'] ?? '',
        map['mobile'] ?? '',
        map['dateOfBirth'] ?? '',
        map['bloodGroup'] ?? '',
        map['fatherName'] ?? '',
        map['gameId'] ?? '',
        map['city'] ?? '',
        map['state'] ?? '',
        map['country'] ?? '',
        map['guardianId'] ?? '',
        map['idFrontImage'] ?? '',
        map['idBackImage'] ?? '',
        map['certificateLink'] ?? '',
        map['height'] ?? 0,
        map['weight'] ?? 0,
        map['address'] ?? '',
        map['isActive'] ?? true,
        map['requests'] ?? {},
        map['motherName'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, role: $role, pic: $pic, gender: $gender, userName: $userName, mobile: $mobile, dateOfBirth: $dateOfBirth, bloodGroup: $bloodGroup, fatherName: $fatherName, gameId: $gameId, city: $city, state: $state, country: $country, guardianId: $guardianId, idFrontImage: $idFrontImage, idBackImage: $idBackImage, certificateLink: $certificateLink, height: $height, weight: $weight, address: $address, isActive: $isActive, requests: $requests)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.role == role &&
        other.pic == pic &&
        other.gender == gender &&
        other.userName == userName &&
        other.mobile == mobile &&
        other.dateOfBirth == dateOfBirth &&
        other.bloodGroup == bloodGroup &&
        other.fatherName == fatherName &&
        other.gameId == gameId &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.guardianId == guardianId &&
        other.idFrontImage == idFrontImage &&
        other.idBackImage == idBackImage &&
        other.certificateLink == certificateLink &&
        other.height == height &&
        other.weight == weight &&
        other.address == address &&
        other.isActive == isActive &&
        mapEquals(other.requests, requests);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        role.hashCode ^
        pic.hashCode ^
        gender.hashCode ^
        userName.hashCode ^
        mobile.hashCode ^
        dateOfBirth.hashCode ^
        bloodGroup.hashCode ^
        fatherName.hashCode ^
        gameId.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        guardianId.hashCode ^
        idFrontImage.hashCode ^
        idBackImage.hashCode ^
        certificateLink.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        address.hashCode ^
        isActive.hashCode ^
        requests.hashCode;
  }
}
