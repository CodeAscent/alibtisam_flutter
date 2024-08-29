// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TestResultsModel {
   num wellness;
   num workload;
   num performance;
   num health;

  TestResultsModel(this.wellness, this.workload, this.performance, this.health);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wellness': wellness,
      'workload': workload,
      'performance': performance,
      'health': health,
    };
  }

  factory TestResultsModel.fromMap(Map<String, dynamic> map) {
    return TestResultsModel(
      map['wellness'] as num,
      map['workload'] as num,
      map['performance'] as num,
      map['health'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestResultsModel.fromJson(String source) => TestResultsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
