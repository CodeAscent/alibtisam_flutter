// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:alibtisam/features/enrollment/models/user.dart';

class SessionAppointment {
  String? id;
  UserModel? userId;
  UserModel? coachId;
  String? dateAndTime;
  String? status;
  String? description;
  bool? isCompleted;
  String? feedbackByCoach;
  String? feedbackByUser;
  SessionAppointment({
    this.id,
    this.userId,
    this.dateAndTime,
    this.status,
    this.description,
    this.isCompleted,
    this.feedbackByCoach,
    this.feedbackByUser,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId?.toMap(),
      'dateAndTime': dateAndTime,
      'status': status,
      'isCompleted': isCompleted,
      'feedbackByCoach': feedbackByCoach,
      'feedbackByUser': feedbackByUser,
    };
  }

  factory SessionAppointment.fromMap(Map<String, dynamic> map) {
    return SessionAppointment(
      id: map['_id'] != null ? map['_id'] as String : null,
      userId: map['userId'] != null
          ? UserModel.fromMap(map['userId'] as Map<String, dynamic>)
          : null,
      dateAndTime:
          map['dateAndTime'] != null ? map['dateAndTime'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      isCompleted: map['isCompleted'] != null ? map['isCompleted'] : false,
      feedbackByCoach: map['feedbackByCoach'] != null
          ? map['feedbackByCoach'] as String
          : null,
      feedbackByUser: map['feedbackByUser'] != null
          ? map['feedbackByUser'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionAppointment.fromJson(String source) =>
      SessionAppointment.fromMap(json.decode(source) as Map<String, dynamic>);
}
