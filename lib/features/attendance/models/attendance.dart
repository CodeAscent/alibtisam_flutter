// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/bottomNav/model/user.dart';

class AttendanceModel {
  final String id;
  final UserModel playerId;
  final String remark;
  final String inTime;
  final String outTime;

  AttendanceModel(
    this.id,
    this.playerId,
    this.remark,
    this.inTime,
    this.outTime,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'playerId': playerId.toMap(),
      'remark': remark,
      'inTime': inTime,
      'outTime': outTime,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      map['_id'],
      UserModel.fromMap(map['playerId'] as Map<String, dynamic>),
      map['remark'] as String,
      map['inTime'] as String,
      map['outTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PlayersAttendance {
  final String id;
  String? remark;
  String? outTime;

  PlayersAttendance({required this.id, this.remark = '', this.outTime = ''});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlayersAttendance && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'remark': remark,
      'outTime': outTime,
    };
  }

  factory PlayersAttendance.fromMap(Map<String, dynamic> map) {
    return PlayersAttendance(
      id: map['id'] as String,
      remark: map['remark'] != null ? map['remark'] as String : null,
      outTime: map['outTime'] != null ? map['outTime'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayersAttendance.fromJson(String source) =>
      PlayersAttendance.fromMap(json.decode(source) as Map<String, dynamic>);
}
