// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/tournamentRequest/models/tournament_data_model.dart';

class TournamentModel {
  final String? id;
  final Map<String, dynamic>? requestedBy;
  final TournamentDataModel? tournamentId;
  final String status;

  TournamentModel(this.id, this.requestedBy, this.tournamentId, this.status);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'requestedBy': requestedBy,
      'tournamentId': tournamentId?.toMap(),
      'status': status,
    };
  }

  factory TournamentModel.fromMap(Map<String, dynamic> map) {
    return TournamentModel(
      map['_id'] != null ? map['_id'] : null,
      map['requestedBy'] != null ? map['requestedBy'] : null,
      map['tournamentId'] != null
          ? TournamentDataModel.fromMap(map['tournamentId'])
          : null,
      map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TournamentModel.fromJson(String source) =>
      TournamentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
