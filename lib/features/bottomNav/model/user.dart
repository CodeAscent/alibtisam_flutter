// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/bottomNav/model/game.dart';

class UserModel {
  final String? id;
  final num? pId;
  final String? name;
  final String? email;
  final String? role;
  final String? pic;
  final String? gender;
  final String? userName;
  final String? mobile;
  final String? dateOfBirth;
  final String? bloodGroup;
  final String? fatherName;
  final String? motherName;
  final String? city;
  final String? state;
  final String? guardianId;
  final String? idFrontImage;
  final String? idBackImage;
  final String? certificateLink;
  final num? height;
  final num? weight;
  final num? chestSize;
  final num? heartBeatingRate;
  final num? highJump;
  final num? lowJump;
  final num? normalChestSize;
  final num? pulseRate;
  final num? shoeSize;
  final String? tshirtSize;
  final num? waistSize;
  final String? address;
  final bool? isActive;
  final dynamic request;
  dynamic stage;
  final String? guardianGovId;
  final String? guardianGovIdExpiry;
  final String? relationWithPlayer;
  final String? playerGovId;
  final String? playerGovIdExpiry;
  final GameModel? gameId;

  UserModel(
      this.id,
      this.pId,
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
      this.city,
      this.state,
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
      this.request,
      this.stage,
      this.guardianGovId,
      this.guardianGovIdExpiry,
      this.relationWithPlayer,
      this.playerGovId,
      this.playerGovIdExpiry,
      this.gameId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pId': pId,
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
      'city': city,
      'state': state,
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
      'stage': stage,
      'guardianGovId': guardianGovId,
      'guardianGovIdExpiry': guardianGovIdExpiry,
      'relationWithPlayer': relationWithPlayer,
      'playerGovId': playerGovId,
      'playerGovIdExpiry': playerGovIdExpiry,
      'gameId': gameId?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['_id'] != null ? map['_id'] as String : null,
      map['pId'] != null ? map['pId'] as num : null,
      map['name'] != null ? map['name'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['role'] != null ? map['role'] as String : null,
      map['pic'] != null ? map['pic'] as String : null,
      map['gender'] != null ? map['gender'] as String : null,
      map['userName'] != null ? map['userName'] as String : null,
      map['mobile'] != null ? map['mobile'] as String : null,
      map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      map['fatherName'] != null ? map['fatherName'] as String : null,
      map['motherName'] != null ? map['motherName'] as String : null,
      map['city'] != null ? map['city'] as String : null,
      map['state'] != null ? map['state'] as String : null,
      map['guardianId'] != null ? map['guardianId'] as String : null,
      map['idFrontImage'] != null ? map['idFrontImage'] as String : null,
      map['idBackImage'] != null ? map['idBackImage'] as String : null,
      map['certificateLink'] != null ? map['certificateLink'] as String : null,
      map['height'] != null ? map['height'] as num : null,
      map['weight'] != null ? map['weight'] as num : null,
      map['chestSize'] != null ? map['chestSize'] as num : null,
      map['heartBeatingRate'] != null ? map['heartBeatingRate'] as num : null,
      map['highJump'] != null ? map['highJump'] as num : null,
      map['lowJump'] != null ? map['lowJump'] as num : null,
      map['normalChestSize'] != null ? map['normalChestSize'] as num : null,
      map['pulseRate'] != null ? map['pulseRate'] as num : null,
      map['shoeSize'] != null ? map['shoeSize'] as num : null,
      map['tshirtSize'] != null ? map['tshirtSize'] as String : null,
      map['waistSize'] != null ? map['waistSize'] as num : null,
      map['address'] != null ? map['address'] as String : null,
      map['isActive'] != null ? map['isActive'] as bool : null,
      map['request'] as dynamic,
      map['stage'] as dynamic,
      map['guardianGovId'] != null ? map['guardianGovId'] as String : null,
      map['guardianGovIdExpiry'] != null
          ? map['guardianGovIdExpiry'] as String
          : null,
      map['relationWithPlayer'] != null
          ? map['relationWithPlayer'] as String
          : null,
      map['playerGovId'] != null ? map['playerGovId'] as String : null,
      map['playerGovIdExpiry'] != null
          ? map['playerGovIdExpiry'] as String
          : null,
      map['gameId'] != null && map['gameId'].runtimeType != String
          ? GameModel.fromMap(map['gameId'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
