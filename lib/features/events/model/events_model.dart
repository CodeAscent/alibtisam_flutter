// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:alibtisam/features/events/model/media_model.dart';

class Events {
  final String id;
  final String name;
  final String category;
  final String dateTime;
  final String location;
  final String description;
  final bool isNew;
  final List<Media> media;

  Events(
      {required this.id,
      required this.name,
      required this.category,
      required this.dateTime,
      required this.location,
      required this.description,
      required this.isNew,
      required this.media});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
      'dateTime': dateTime,
      'location': location,
      'description': description,
      'isNew': isNew,
      'media': media.map((x) => x.toMap()).toList(),
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      id: map['_id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      dateTime: map['dateTime'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      isNew: map['isNew'] as bool,
      media: List<Media>.from(
        (map['media']).map(
          (x) => Media.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) =>
      Events.fromMap(json.decode(source) as Map<String, dynamic>);

  Events copyWith({
    String? id,
    String? name,
    String? category,
    String? dateTime,
    String? location,
    String? description,
    bool? isNew,
    List<Media>? media,
  }) {
    return Events(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      description: description ?? this.description,
      isNew: isNew ?? this.isNew,
      media: media ?? this.media,
    );
  }
}
