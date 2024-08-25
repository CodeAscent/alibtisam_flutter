// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrainingPlan {
  final String? groupId;
  final String? stage;
  final String? planName;
  final List<dynamic>? trainingDays;
  final String? trainingTime;
  final String? trainingDuration;
  final String? additionalNotes;

  TrainingPlan(this.groupId, this.stage, this.planName, this.trainingDays,
      this.trainingTime, this.trainingDuration, this.additionalNotes);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupId': groupId,
      'stage': stage,
      'planName': planName,
      'trainingDays': trainingDays,
      'trainingTime': trainingTime,
      'trainingDuration': trainingDuration,
      'additionalNotes': additionalNotes,
    };
  }

  factory TrainingPlan.fromMap(Map<String, dynamic> map) {
    return TrainingPlan(
      map['groupId'] != null ? map['groupId'] as String : "",
      map['stage'] != null ? map['stage'] as String : "",
      map['planName'] != null ? map['planName'] as String : "",
      map['trainingDays'] != null
          ? List<dynamic>.from(map['trainingDays'] as List<dynamic>)
          : [],
      map['trainingTime'] != null ? map['trainingTime'] as String : "",
      map['trainingDuration'] != null ? map['trainingDuration'] as String : "",
      map['additionalNotes'] != null ? map['additionalNotes'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingPlan.fromJson(String source) =>
      TrainingPlan.fromMap(json.decode(source) as Map<String, dynamic>);
}
