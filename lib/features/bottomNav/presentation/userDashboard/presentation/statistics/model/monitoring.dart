// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/model/readiness.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/model/test_results.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/statistics/model/training_load.dart';

class MonitoringModel {
  final String playerId;
  final num readinessPercent;
  final num trainingLoadPercent;
  final num testResultsPercent;
  final num readinessOverallPercent;
  final num trainingLoadOverallPercent;
  final num testResultsOverallPercent;
  final String injuryStatus;
  final TestResultsModel testResults;
  final TrainingLoadModel trainingLoad;
  final ReadinessModel readiness;
  final String updatedAt;

  MonitoringModel(
      this.playerId,
      this.readinessPercent,
      this.trainingLoadPercent,
      this.testResultsPercent,
      this.readinessOverallPercent,
      this.trainingLoadOverallPercent,
      this.testResultsOverallPercent,
      this.injuryStatus,
      this.testResults,
      this.trainingLoad,
      this.readiness,
      this.updatedAt);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playerId': playerId,
      'readinessPercent': readinessPercent,
      'trainingLoadPercent': trainingLoadPercent,
      'testResultsPercent': testResultsPercent,
      'readinessOverallPercent': readinessOverallPercent,
      'trainingLoadOverallPercent': trainingLoadOverallPercent,
      'testResultsOverallPercent': testResultsOverallPercent,
      'injuryStatus': injuryStatus,
      'testResults': testResults.toMap(),
      'trainingLoad': trainingLoad.toMap(),
      'readiness': readiness.toMap(),
      'updatedAt': updatedAt,
    };
  }

  factory MonitoringModel.fromMap(Map<String, dynamic> map) {
    return MonitoringModel(
      map['playerId'] as String,
      map['readinessPercent'] as num,
      map['trainingLoadPercent'] as num,
      map['testResultsPercent'] as num,
      map['readinessOverallPercent'] as num,
      map['trainingLoadOverallPercent'] as num,
      map['testResultsOverallPercent'] as num,
      map['injuryStatus'] as String,
      TestResultsModel.fromMap(map['testResults'] as Map<String, dynamic>),
      TrainingLoadModel.fromMap(map['trainingLoad'] as Map<String, dynamic>),
      ReadinessModel.fromMap(map['readiness'] as Map<String, dynamic>),
      map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MonitoringModel.fromJson(String source) =>
      MonitoringModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
