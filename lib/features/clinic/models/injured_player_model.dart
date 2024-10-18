// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/statistics/model/readiness.dart';

class InjuredPlayerModel {
  String? id;
  String? userId;
  ReadinessModel? readiness;
  String? name;
  String? pic;
  num? pId;
  bool? isAppointmentMade;
  InjuredPlayerModel({
    this.id,
    this.userId,
    this.readiness,
    this.name,
    this.pic,
    this.pId,
    this.isAppointmentMade
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'name': name,
      'pic': pic,
      'pId': pId,
      'isAppointmentMade':isAppointmentMade
    };
  }

  factory InjuredPlayerModel.fromMap(Map<String, dynamic> map) {
    return InjuredPlayerModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      readiness: map['readiness'] != null
          ? ReadinessModel.fromMap(map['readiness'])
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      pic: map['pic'] != null ? map['pic'] as String : null,
      pId: map['pId'] != null ? map['pId'] as num : null,
      isAppointmentMade: map['isAppointmentMade'] != null ? map['isAppointmentMade'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory InjuredPlayerModel.fromJson(String source) =>
      InjuredPlayerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
