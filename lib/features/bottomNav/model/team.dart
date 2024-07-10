// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/bottomNav/model/user.dart';

class TeamModel {
  final String name;
  final String id;
  final String gameId;
  final num totalPlayer;
  final num playingPlayer;
  final String organizationId;
  final List<PlayersModel> players;

  TeamModel(this.name, this.id, this.gameId, this.totalPlayer,
      this.playingPlayer, this.organizationId, this.players);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'gameId': gameId,
      'totalPlayer': totalPlayer,
      'playingPlayer': playingPlayer,
      'organizationId': organizationId,
      'players': players.map((x) => x.toMap()).toList(),
    };
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      map['name'] as String,
      map['_id'] as String,
      map['gameId'] as String,
      map['totalPlayer'] as num,
      map['playingPlayer'] as num,
      map['organizationId'] as String,
      List<PlayersModel>.from(
        (map['players']).map<PlayersModel>(
          (x) => PlayersModel.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(String source) =>
      TeamModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PlayersModel {
  final UserModel playerId;
  final bool isPlaying;

  PlayersModel(this.playerId, this.isPlaying);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playerId': playerId.toMap(),
      'isPlaying': isPlaying,
    };
  }

  factory PlayersModel.fromMap(Map<String, dynamic> map) {
    return PlayersModel(
      UserModel.fromMap(map['playerId']),
      map['isPlaying'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayersModel.fromJson(String source) =>
      PlayersModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
