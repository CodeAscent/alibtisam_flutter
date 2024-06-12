// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:SNP/features/bottomNav/model/attendance.dart';
import 'package:SNP/features/bottomNav/model/team.dart';
import 'package:SNP/features/bottomNav/model/user.dart';

class AttendanceHistoryModel {
  final String id;
  final Map<String, dynamic> teamId;
  final List<AttendanceModel> players;
  final String createdAt;

  AttendanceHistoryModel(
    this.id,
    this.teamId,
    this.players,
    this.createdAt,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'teamId': teamId,
      'players': players.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
    };
  }

  factory AttendanceHistoryModel.fromMap(Map<String, dynamic> map) {
    return AttendanceHistoryModel(
      map['_id'] as String,
      Map<String, dynamic>.from(map['teamId']),
      List<AttendanceModel>.from(
        map['players'].map<AttendanceModel>(
          (x) => AttendanceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      map['createdAt'].toString()
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceHistoryModel.fromJson(String source) =>
      AttendanceHistoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
