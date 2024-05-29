// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:video_player/video_player.dart';

class Collection {
  final dynamic media;
  final String type;

  Collection({required this.media, required this.type});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'media': media,
      'type': type,
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      media: map['type'] == 'video'
          ? VideoPlayerController.networkUrl(Uri.parse(map['media']))
          : map['media'],
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source) as Map<String, dynamic>);
}
