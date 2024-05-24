// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  final String guardianId;
  final String idFrontImage;
  final String idBackImage;
  final String certificateLink;
  final num height;
  final num weight;
  final num chestSize;
  final num heartBeatingRate;
  final num highJump;
  final num lowJump;
  final num normalChestSize;
  final num pulseRate;
  final num shoeSize;
  final String tshirtSize;
  final num waistSize;
  final String address;
  final bool isActive;
  final Map<String, dynamic> request;

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
      this.motherName,
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
      this.chestSize,
      this.heartBeatingRate,
      this.highJump,
      this.lowJump,
      this.normalChestSize,
      this.pulseRate,
      this.shoeSize,
      this.tshirtSize,
      this.waistSize,
      this.address,
      this.isActive,
      this.request);

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
      'motherName': motherName,
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
      'chestSize': chestSize,
      'heartBeatingRate': heartBeatingRate,
      'highJump': highJump,
      'lowJump': lowJump,
      'normalChestSize': normalChestSize,
      'pulseRate': pulseRate,
      'shoeSize': shoeSize,
      'tshirtSize': tshirtSize,
      'waistSize': waistSize,
      'address': address,
      'isActive': isActive,
      'request': request,
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
      map['motherName'] ?? '',
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
      map['chestSize'] ?? 0,
      map['heartBeatingRate'] ?? 0,
      map['highJump'] ?? 0,
      map['lowJump'] ?? 0,
      map['normalChestSize'] ?? 0,
      map['pulseRate'] ?? 0,
      map['shoeSize'] ?? 0,
      map['tshirtSize'] ?? '',
      map['waistSize'] ?? 0,
      map['address'] ?? '',
      map['isActive'] as bool,
      Map<String, dynamic>.from(map['request'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
