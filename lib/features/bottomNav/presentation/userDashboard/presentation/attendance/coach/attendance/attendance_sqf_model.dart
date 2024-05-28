// ignore_for_file: public_member_api_docs, sort_constructors_first
class AttendanceDB {
  final int? sno;
  final String id;
  final int playerId;
  String remark;
  final String name;
  String? inTime;
  String? outTime;
  AttendanceDB(
      {required this.id,
      required this.playerId,
      required this.name,
      required this.inTime,
      required this.remark,
      this.outTime,
      this.sno});
  factory AttendanceDB.fromJson(json) => AttendanceDB(
      sno: json["sno"],
      id: json["id"],
      playerId: json["playerId"],
      name: json["name"],
      inTime: json["inTime"],
      outTime: json["outTime"],
      remark: json["remark"]);

  Map<String, dynamic> toJson() => {
        "sno": sno,
        "name": name,
        "id": id,
        "playerId": playerId,
        "inTime": inTime,
        "outTime": outTime,
        "remark": remark
      };
}
