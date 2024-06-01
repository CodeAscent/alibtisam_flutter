import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/attendance/coach/attendance/attendance_sqf_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Attendance.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(_dbName),
      version: _version,
      onCreate: (db, version) async => await db.execute(
          'CREATE TABLE Attendance (sno INTEGER PRIMARY KEY, id TEXT NOT NULL, remark TEXT NOT NULL, playerId INTEGER NOT NULL, name TEXT NOT NULL, inTime TEXT, outTime TEXT)'),
    );
  }

  static Future<int> addAttendance(AttendanceDB attendanceDB) async {
    final db = await _getDB();
    List<Map<String, dynamic>> existingRecords = await db.query(
      'Attendance',
      where: 'playerId = ?',
      whereArgs: [attendanceDB.playerId],
    );
    if (existingRecords.isNotEmpty) {
      return await db.delete("Attendance",
          where: "playerId = ?", whereArgs: [attendanceDB.playerId]);
    } else {
      return await db.insert(
        'Attendance',
        attendanceDB.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<int> updateAttendance(AttendanceDB attendanceDB) async {
    final db = await _getDB();
    return await db.update("Attendance", attendanceDB.toJson(),
        where: "playerId = ?",
        whereArgs: [attendanceDB.playerId],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteAttendance(id) async {
    final db = await _getDB();
    return await db.delete(
      "Attendance",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<int> absentAttendance(AttendanceDB attendanceDB) async {
    final db = await _getDB();
    return await db.delete(
      "Attendance",
      where: "playerId = ?",
      whereArgs: [attendanceDB.playerId],
    );
  }

  static Future<List<AttendanceDB>?> getAttendance() async {
    final db = await _getDB();
    List<Map<String, dynamic>> map = await db.query("Attendance");
    if (map.isEmpty) {
      return null;
    }
    return List.generate(map.length, (index) {
      return AttendanceDB.fromJson(map[index]);
    });
  }
}
