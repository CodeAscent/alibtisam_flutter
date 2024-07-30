// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrainingLoadModel {
  num monday;
  num tuesday;
  num wednesday;
  num thursday;
  num friday;
  num saturday;
  num sunday;
  TrainingLoadModel({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
    };
  }

  factory TrainingLoadModel.fromMap(Map<String, dynamic> map) {
    return TrainingLoadModel(
      monday: map['monday'] as num,
      tuesday: map['tuesday'] as num,
      wednesday: map['wednesday'] as num,
      thursday: map['thursday'] as num,
      friday: map['friday'] as num,
      saturday: map['saturday'] as num,
      sunday: map['sunday'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingLoadModel.fromJson(String source) =>
      TrainingLoadModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
