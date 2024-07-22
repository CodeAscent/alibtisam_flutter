// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/bottomNav/model/age_category.dart';
import 'package:alibtisam/features/bottomNav/model/attendance.dart';

class AttendanceHistoryModel {
  final String id;
  final List<AttendanceModel> players;
  final String createdAt;

  AttendanceHistoryModel(
    this.id,
    this.players,
    this.createdAt,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'players': players.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
    };
  }

  factory AttendanceHistoryModel.fromMap(Map<String, dynamic> map) {
    return AttendanceHistoryModel(
      map['_id'] as String,
      List<AttendanceModel>.from(
        (map['players'] as List<dynamic>).map<AttendanceModel>(
          (x) => AttendanceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceHistoryModel.fromJson(String source) =>
      AttendanceHistoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
