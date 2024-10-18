// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/enrollment/models/user.dart';

class PlayerAppointmentModel {
  String? id;
  UserModel? userId;
  String? status;
  String? createdBy;
  String? injuryDescription;
  String? injuryBodyImage;
  List<ClinicAppointments?>? clinicAppointments;
  String? userAppointmentType;
  String? paymentStatus;
  bool? paymentRequested;
  num? amount;
  PlayerAppointmentModel({
    this.id,
    this.userId,
    this.status,
    this.createdBy,
    this.injuryDescription,
    this.injuryBodyImage,
    this.clinicAppointments,
    this.userAppointmentType,
    this.paymentStatus,
    this.paymentRequested,
    this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId?.toMap(),
      'status': status,
      'createdBy': createdBy,
      'injuryDescription': injuryDescription,
      'injuryBodyImage': injuryBodyImage,
      'clinicAppointments': clinicAppointments,
      'userAppointmentType': userAppointmentType,
      'paymentStatus': paymentStatus,
      'paymentRequested': paymentRequested,
      'amount': amount,
    };
  }

  factory PlayerAppointmentModel.fromMap(Map<String, dynamic> map) {
    return PlayerAppointmentModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      userId: map['userId'] != null
          ? UserModel.fromMap(map['userId'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      injuryDescription: map['injuryDescription'] != null
          ? map['injuryDescription'] as String
          : null,
      injuryBodyImage: map['injuryBodyImage'] != null
          ? map['injuryBodyImage'] as String
          : null,
      clinicAppointments: map['clinicAppointments'] != null
          ? List<ClinicAppointments?>.from(
              (map['clinicAppointments']).map<ClinicAppointments?>(
                (x) => ClinicAppointments?.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      userAppointmentType: map['userAppointmentType'] != null
          ? map['userAppointmentType'] as String
          : null,
      paymentStatus:
          map['paymentStatus'] != null ? map['paymentStatus'] as String : null,
      paymentRequested: map['paymentRequested'] != null
          ? map['paymentRequested'] as bool
          : null,
      amount: map['amount'] != null ? map['amount'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerAppointmentModel.fromJson(String source) =>
      PlayerAppointmentModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class ClinicAppointments {
  String? appointmentDate;
  String? recoveryStatus;
  String? feedback;

  ClinicAppointments({
    this.feedback,
    this.appointmentDate,
    this.recoveryStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appointmentDate': appointmentDate,
      'recoveryStatus': recoveryStatus,
      'feedback': feedback,
    };
  }

  factory ClinicAppointments.fromMap(Map<String, dynamic> map) {
    return ClinicAppointments(
      appointmentDate: map['appointmentDate'] != null
          ? map['appointmentDate'] as String
          : null,
      recoveryStatus: map['recoveryStatus'] != null
          ? map['recoveryStatus'] as String
          : null,
      feedback: map['feedback'] != null ? map['feedback'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicAppointments.fromJson(String source) =>
      ClinicAppointments.fromMap(json.decode(source) as Map<String, dynamic>);
}
