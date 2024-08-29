// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Media {
  final String url;
  final String type;
  Media({required this.url, required this.type});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'type': type,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      url: map['url'],
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) =>
      Media.fromMap(json.decode(source) as Map<String, dynamic>);
}
