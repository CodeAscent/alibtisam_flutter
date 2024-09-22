import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AlrwaadPlan {
  String? planName;
  num? price;
  AlrwaadPlan({
    this.planName,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'planName': planName,
      'price': price,
    };
  }

  factory AlrwaadPlan.fromMap(Map<String, dynamic> map) {
    return AlrwaadPlan(
      planName: map['planName'] != null ? map['planName'] as String : '',
      price: map['price'] != null ? map['price'] as num : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlrwaadPlan.fromJson(String source) =>
      AlrwaadPlan.fromMap(json.decode(source) as Map<String, dynamic>);
}
