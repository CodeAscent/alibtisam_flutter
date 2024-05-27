// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrainingLoadModel {
  num monday;
  num tuesday;
  num wednesday;
  num thursday;
  num sunday;

  TrainingLoadModel(
      this.monday, this.tuesday, this.wednesday, this.thursday, this.sunday);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'sunday': sunday,
    };
  }

  factory TrainingLoadModel.fromMap(Map<String, dynamic> map) {
    return TrainingLoadModel(
      map['monday'] as num,
      map['tuesday'] as num,
      map['wednesday'] as num,
      map['thursday'] as num,
      map['sunday'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingLoadModel.fromJson(String source) =>
      TrainingLoadModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
