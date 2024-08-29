// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReadinessModel {
   num hydration;
   num stress;
   num sleep;
   num overall;
   num nutrition;
   num injury;

  ReadinessModel(this.hydration, this.stress, this.sleep, this.overall, this.nutrition, this.injury);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hydration': hydration,
      'stress': stress,
      'sleep': sleep,
      'overall': overall,
      'nutrition': nutrition,
      'injury': injury,
    };
  }

  factory ReadinessModel.fromMap(Map<String, dynamic> map) {
    return ReadinessModel(
      map['hydration'] as num,
      map['stress'] as num,
      map['sleep'] as num,
      map['overall'] as num,
      map['nutrition'] as num,
      map['injury'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReadinessModel.fromJson(String source) => ReadinessModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
