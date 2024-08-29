// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AttendanceStatisticsModel {
  final num presentDays;
  final Map<String, dynamic> weeklyStats;
  final Map<String, dynamic> monthlyStats;
  final Map<String, dynamic> yearlyStats;

  AttendanceStatisticsModel(
      this.presentDays, this.weeklyStats, this.monthlyStats, this.yearlyStats);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'presentDays': presentDays,
      'weeklyStats': weeklyStats,
      'monthlyStats': monthlyStats,
      'yearlyStats': yearlyStats,
    };
  }

  factory AttendanceStatisticsModel.fromMap(Map<String, dynamic> map) {
    return AttendanceStatisticsModel(
      map['presentDays'] as num,
      Map<String, dynamic>.from(map['weeklyStats'] as Map<String, dynamic>),
      Map<String, dynamic>.from(map['monthlyStats'] as Map<String, dynamic>),
      Map<String, dynamic>.from(map['yearlyStats'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceStatisticsModel.fromJson(String source) =>
      AttendanceStatisticsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
