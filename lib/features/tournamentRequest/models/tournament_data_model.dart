// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/enrollment/models/user.dart';

class TournamentDataModel {
  final String? id;
  final String? name;
  final String? startDate;
  final String? endDate;
  final String? status;
  final String? type;
  final String? location;
  final String? description;
  final String? travelDate;
  final String? transportMedium;
  final String? expectedDeparture;
  final String? expectedArrival;
  final String? from;
  final String? to;
  final List<UserModel>? playerIds;
  final List<UserModel>? coachIds;
  final int? requestedAmount;
  final String? createdAt;
  final String? teamName;
  num? approvedAmount;
  num? remainingAmount;
  num? exceededAmount;
  dynamic receipts;

  TournamentDataModel(
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.status,
    this.type,
    this.location,
    this.description,
    this.travelDate,
    this.transportMedium,
    this.expectedDeparture,
    this.expectedArrival,
    this.from,
    this.to,
    this.playerIds,
    this.coachIds,
    this.requestedAmount,
    this.createdAt,
    this.teamName,
    this.approvedAmount,
    this.remainingAmount,
    this.exceededAmount,
    this.receipts,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'type': type,
      'location': location,
      'description': description,
      'travelDate': travelDate,
      'transportMedium': transportMedium,
      'expectedDeparture': expectedDeparture,
      'expectedArrival': expectedArrival,
      'from': from,
      'to': to,
      'playerIds': playerIds,
      'coachIds': coachIds,
      'requestedAmount': requestedAmount,
      'createdAt': createdAt,
      'teamName': teamName,
      'approvedAmount': approvedAmount,
      'remainingAmount': remainingAmount,
      'exceededAmount': exceededAmount,
      'receipts': receipts,
    };
  }

  factory TournamentDataModel.fromMap(Map<String, dynamic> map) {
    return TournamentDataModel(
      map['_id'] != null ? map['_id'] : null,
      map['name'] != null ? map['name'] : null,
      map['startDate'] != null ? map['startDate'] : null,
      map['endDate'] != null ? map['endDate'] : null,
      map['status'] != null ? map['status'] : null,
      map['type'] != null ? map['type'] : null,
      map['location'] != null ? map['location'] : null,
      map['description'] != null ? map['description'] : null,
      map['travelDate'] != null ? map['travelDate'] : null,
      map['transportMedium'] != null ? map['transportMedium'] : null,
      map['expectedDeparture'] != null ? map['expectedDeparture'] : null,
      map['expectedArrival'] != null ? map['expectedArrival'] : null,
      map['from'] != null ? map['from'] : null,
      map['to'] != null ? map['to'] : null,
      map['playerIds'] != null
          ? List<UserModel>.from(
              (map['playerIds']).map<UserModel?>(
                (x) => UserModel.fromMap(x),
              ),
            )
          : null,
      map['coachIds'] != null
          ? List<UserModel>.from(
              (map['coachIds']).map<UserModel?>(
                (x) => UserModel.fromMap(x),
              ),
            )
          : null,
      map['requestedAmount'] != null ? map['requestedAmount'] : null,
      map['createdAt'] != null ? map['createdAt'] : null,
      map['teamName'] != null ? map['teamName'] : null,
      map['approvedAmount'] != null ? map['approvedAmount'] : 0,
      map['remainingAmount'] != null ? map['remainingAmount'] : 0,
      map['exceededAmount'] != null ? map['exceededAmount'] : 0,
      map['receipts'] != null ? map['receipts'] : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory TournamentDataModel.fromJson(String source) =>
      TournamentDataModel.fromMap(json.decode(source));
}
